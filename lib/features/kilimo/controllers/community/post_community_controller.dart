import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/repositories/post/post_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/helpers/network_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';
import '../../models/community/post_modal.dart';

class PostCommunityController extends GetxController {
  static PostCommunityController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final postRepository = Get.put(PostRepository());
  
  final selectedCrop = ''.obs;
  final problemTitle = ''.obs;
  final problemDescription = ''.obs;
  final uid = const Uuid().v4();

  final TextEditingController problemTitleController = TextEditingController();
  final TextEditingController problemDescriptionController = TextEditingController();

  final imageFile = Rxn<File>(); // Use Rxn for better null handling
  final isImageUploaded = false.obs;
  final isLoading = false.obs; // For loading indicator

  @override
  void onInit() {
    super.onInit();
    problemTitleController.addListener(() {
      problemTitle.value = problemTitleController.text;
    });
    problemDescriptionController.addListener(() {
      problemDescription.value = problemDescriptionController.text;
    });
  }

  @override
  void onClose() {
    problemTitleController.dispose();
    problemDescriptionController.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      isImageUploaded.value = true; // Mark image as uploaded
    }
  }

  Future<String?> uploadImageToFirebase(File image) async {
    try {
      Reference ref = FirebaseStorage.instance
        .ref()
        .child('crop_images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> submitPost() async {
    if (imageFile.value == null || selectedCrop.value.isEmpty || problemTitle.value.isEmpty || problemDescription.value.isEmpty) {
      TLoaders.warningSnackBar(
        title: 'Error',
        message: 'Please fill in all fields and select an image.',
      );
      return;
    }

    try {
      // Start Loading
      isLoading.value = true; // Show loading indicator
      TFullScreenLoader.openLoadingDialog('We are processing your information', TImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }
      
      // Fetch user details
      final user = await userRepository.fetchUserDetails();

      // Get user's current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String userLocation = '${position.latitude}, ${position.longitude}';

      // Check if the image is uploaded
      if (imageFile.value == null) {
        TLoaders.warningSnackBar(
          title: 'Image not uploaded',
          message: 'Please upload an image of your crop before submitting the post',
        );
        return;
      }
      
      // Upload the image to Firebase Storage
      String? imageUrl = await uploadImageToFirebase(imageFile.value!);

      if (imageUrl == null) {
        throw Exception('Failed to upload image');
      }
      
      // Check if user data is loaded
      if (user.id.isEmpty) {
        // Map Data
        final post = PostModal(
          id: uid,
          cropType: selectedCrop.value,
          problemTitle: problemTitle.value.trim(),
          problemDescription: problemDescription.value.trim(),
          cropImage: imageUrl,
          userId: user.id,
          userName: user.username,
          userLocation: userLocation,
          date: DateTime.now(),
        );

        // Save user data to Firestore
        await postRepository.savePostRecord(post);

        // Reset image
        imageFile.value = null;
        isImageUploaded.value = false;

        // Remove Loader
        TFullScreenLoader.stopLoading();

        TLoaders.successSnackBar(
          title: 'Success',
          message: 'Post submitted successfully!',
        );
      } else {
        // Handle the case where user details couldn't be fetched
        throw Exception('Failed to get user details');
      }
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: 'Post not sent',
        message: 'Something went wrong posting your problem. You can re-post your post in your community',
      );
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }
}
