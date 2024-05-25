import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/post/post_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/helpers/network_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';
import '../../../personalization/models/user_modal.dart';
import '../../models/community/post_modal.dart';

class PostCommunityController extends GetxController {
  static PostCommunityController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final postRepository = Get.put(PostRepository());
  
  final selectedCrop = ''.obs;
  final problemTitle = ''.obs;
  final problemDescription = ''.obs;
  final location = ''.obs;
  final uid = const Uuid().v4();

  final problemTitleController = TextEditingController();
  final problemDescriptionController = TextEditingController();
  final locationController = TextEditingController();

  final imageFile = Rxn<File>(); // Use Rxn for better null handling
  final isImageUploaded = false.obs;
  final isLoading = false.obs; // For loading indicator

  @override
  void onInit() {
    super.onInit();
    problemTitleController.addListener(() {
      problemTitle.value = problemTitleController.text.trim();
    });
    problemDescriptionController.addListener(() {
      problemDescription.value = problemDescriptionController.text.trim();
    });
    locationController.addListener(() {
      location.value = locationController.text.trim();
    });
  }

  @override
  void onClose() {
    problemTitleController.dispose();
    problemDescriptionController.dispose();
    locationController.dispose();
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

  Future<String?> uploadImageToFirebase(String path, File image) async {
    try {
      final ref = FirebaseStorage.instance
        .ref()
        .child(path)
        .child(AuthenticationRepository.instance.authUser!.uid);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
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
      UserModal user = await userRepository.fetchUserDetails();

      // Check if the image is uploaded
      if (imageFile.value == null) {
        TLoaders.warningSnackBar(
          title: 'Image not uploaded',
          message: 'Please upload an image of your crop before submitting the post',
        );
        return;
      }
      
      // Upload the image to Firebase Storage
      String? imageUrl = await uploadImageToFirebase('Posts/Images/', imageFile.value!);

      if (imageUrl == null) {
        return TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Failed to upload image');
      }
      
      // Check if user data is loaded
      if (user.id.isEmpty) {
        // Map Data
        final newPost = PostModal(
          id: uid,
          cropType: selectedCrop.value,
          problemTitle: problemTitle.value,
          problemDescription: problemDescription.value,
          cropImage: imageUrl,
          userId: user.id,
          userName: user.username,
          userLocation: location.value,
          date: DateTime.now(),
        );

        // Save user data to Firestore
        await postRepository.savePostRecord(newPost);

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
        TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Failed to get user details');
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
