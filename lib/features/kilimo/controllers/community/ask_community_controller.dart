import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; 
import 'package:realm/realm.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../models/community/post.dart';

class AskCommunityController extends GetxController {
  // Create a Configuration object
  final config = Configuration.local([Post.schema]);

  final ImagePicker _picker = ImagePicker();

  // Observables to track form data
  final problemTitle = TextEditingController().obs;
  final problemDescription = TextEditingController().obs;
  RxString selectedCrop = ''.obs; 
  Rx<File?> selectedImage = Rx(null);
  var isImageUploaded = false.obs;

  // Image picking logic
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final cacheDirectoryPath = await getCacheDirectoryPath();
      final newImagePath = '$cacheDirectoryPath/${pickedFile.name}';

      // Create a File object using XFile.readAsBytes()
      final imageBytes = await pickedFile.readAsBytes();
      final newImageFile = await File(newImagePath).writeAsBytes(imageBytes);

      selectedImage.value = newImageFile;
      debugPrint("Image Path: ${selectedImage.value!.path}");
    }
  }

  // Data submission
  Future<void> submitData() async {
    // Open a Realm
    final realm = Realm(config);

    // Basic validation
    if (_validateData()) {
      // Get user data from Firebase
      final userRepository = Get.put(UserRepository());
      final user = await userRepository.fetchUserDetails();

      // Get user's current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      String userLocation = '${position.latitude}, ${position.longitude}';
      
      final newPost = Post(
        ObjectId(),
        selectedCrop.value,
        selectedImage.value!.path,
        problemTitle.value.text,
        problemDescription.value.text,
        user.id, 
        user.username,
        userLocation,
        0, // Initialize upvotes
        0, // Initialize downvotes
        0, // Initialize reply count
        user.profilePicture,
        DateTime.now()
      );

      // 3. Save Post (Realm) 
      try {
        // Open a write transaction
          realm.write(() {
          realm.add(newPost);
        });

        _resetForm();
        
        THelperFunctions.showSnackBar('Post Submitted');
      } catch (e) {
        debugPrint('Error submitting data: $e');
        THelperFunctions.showSnackBar('Failed to post data. Please try again.');
      } finally {
        // Close the realm
        realm.close();
      }
    }
  }

  setSelectedCrop(String crop) {
    selectedCrop.value = crop; 
  }

  // Method to validate form data
  bool _validateData() {
    return selectedCrop.value.isNotEmpty &&
      problemTitle.value.text.isNotEmpty &&
      problemDescription.value.text.isNotEmpty;
  }

  void _resetForm() {
    selectedCrop.value = ''; // Reset selectedCrop (Assuming it's an RxString)
    selectedImage.value = null; // Reset Rx<File?>
    problemTitle.value.clear();  // Clear problem TextEditingController
    problemDescription.value.clear(); // Clear problemDescription TextEditingController
  }

  Future<String> getCacheDirectoryPath() async {
  final directory = await getTemporaryDirectory(); 
  return directory.path;
}
}
