import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repositories/post/post_repository.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/helpers/network_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';
import '../../models/community/post_modal.dart';
import '../../models/community/reply_modal.dart';

class PostCommunityController extends GetxController {
  static PostCommunityController get instance => Get.find();

  final PostRepository postRepository = Get.find<PostRepository>();
  
  // Rx variables for reactive updates
  RxString selectedCrop = ''.obs;
  
  final problemTitle = ''.obs;
  final problemDescription = ''.obs;
  final location = ''.obs;
  final replyMessage = ''.obs;

  final problemTitleController = TextEditingController();
  final problemDescriptionController = TextEditingController();
  final locationController = TextEditingController();
  final replyController = TextEditingController();

  final imageFile = Rxn<File>(); // Use Rxn for better null handling
  var user = Rx<User?>(null);
  Rx<PostModal> selectedPost = PostModal.empty().obs;
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
    replyController.addListener(() {
      replyMessage.value = replyController.text.trim();
    });
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  @override
  void dispose() {
    problemTitleController.dispose();
    problemDescriptionController.dispose();
    locationController.dispose();
    replyController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      isImageUploaded.value = true; // Mark image as uploaded
    }
  }

  Future<String> uploadImageToFirebase(String path, File image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.toString());
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> submitPost() async {
    // Form validation (combined into one condition for brevity)
    if (imageFile.value == null || selectedCrop.value.isEmpty || problemTitle.value.isEmpty || problemDescription.value.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Please fill in all fields and select an image.',
      );
      return;
    }

    if (user.value == null) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'User not authenticated',
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

      String userId = user.value!.uid;
      
      // Fetch user details from Firestore (assuming user details are stored in a collection 'users')
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();

      String userName = userDoc['UserName'];

      // Check if the image is uploaded
      if (imageFile.value == null) {
        TLoaders.warningSnackBar(
          title: 'Image not uploaded',
          message: 'Please upload an image of your crop before submitting the post',
        );
        return;
      }
      
      // Upload the image to Firebase Storage
      String imageUrl = await uploadImageToFirebase('Posts/Images/', imageFile.value!);
      
      // Create and Save Post with User Information
      final newPost = PostModal(
        id: '',
        cropType: selectedCrop.value,
        problemTitle: problemTitle.value,
        problemDescription: problemDescription.value,
        cropImage: imageUrl,
        userId: userId,
        userName: userName,
        userLocation: location.value,
        date: DateTime.now(),
      );

      // Save post data to Firestore
      FirebaseFirestore.instance.collection('Posts').add(newPost.toJson());

      // Reset image
      imageFile.value = null;
      isImageUploaded.value = false;

      // Remove Loader
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Post submitted successfully!',
      );
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: 'Post not sent',
        message: 'Something went wrong posting your problem: $e',
      );
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  void fetchPostDetails(String postId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> postDoc = await FirebaseFirestore.instance.collection('Posts').doc(postId).get();
      if (postDoc.exists) {
        selectedPost.value = PostModal.fromSnapshot(postDoc);
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch post details: $e',
      );
    }
  }

  Future<void> addReply(String postId) async {
    // Form validation (combined into one condition for brevity)
    if (replyMessage.value.isEmpty) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Please fill in all fields..',
      );
      return;
    }

    if (user.value == null) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'User not authenticated',
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

      String userId = user.value!.uid;
      
      // Fetch user details from Firestore (assuming user details are stored in a collection 'users')
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();

      String userName = userDoc['UserName'];
      String profileImage = userDoc['ProfilePicture'];

      // Create and Save Post with User Information
      final reply = ReplyModal(
        id: postId,
        replyText: replyMessage.value,
        userId: userId,
        userName: userName,
        profileImage: profileImage,
        date: DateTime.now(),
      );

      await FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Replies')
        .add(reply.toJson());
      
      // Clear the reply text field
      replyController.clear();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Reply added successfully',
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to add reply: $e',
      );
    }
  }

  // Method to fetch the stream of replies for a specific post
  Stream<QuerySnapshot> getRepliesStream(String postId) {
    return FirebaseFirestore.instance
      .collection('Posts')
      .doc(postId)
      .collection('Replies')
      .orderBy('Date', descending: true)
      .snapshots();
  }
}
