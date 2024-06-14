import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/constants/image_strings.dart';
import '../../../util/helpers/network_manager.dart';
import '../../../util/popups/full_screen_loader.dart';
import '../../../util/popups/loaders.dart';
import '../models/feedback_modal.dart';

class FeedBackController extends GetxController {
  static FeedBackController get instance => Get.find();

  final feedback = TextEditingController();
  var user = Rx<User?>(null);
  GlobalKey<FormState> feedbackFormKey = GlobalKey<FormState>();
  final isLoading = false.obs; // For loading indicator

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  // feeedback
  void sendFeedback() async {
    // Form Validation
    if (!feedbackFormKey.currentState!.validate()) {
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

      // Create and Save Post with User Information
      final newFeedBack = FeedBackModal(
        id: '',
        feedBack: feedback.text.trim(),
        userId: userId,
        userName: userName,
        date: DateTime.now(),
      );

      // Save post data to Firestore
      FirebaseFirestore.instance.collection('Feedbacks').add(newFeedBack.toJson());

      // Clear the feedback text field
      feedback.clear();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Success',
        message: 'FeedBack submitted successfully!',
      );
    } catch (e) {
      // remove Loader
      TFullScreenLoader.stopLoading();

      // Show some generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
