import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilimo_app/data/repositories/authentication/authentication_repository.dart';
import 'package:kilimo_app/data/repositories/user/user_repository.dart';
import 'package:kilimo_app/features/authentication/screens/signup/verify_email.dart';
import 'package:kilimo_app/util/constants/image_strings.dart';

import '../../../../util/helpers/network_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';
import '../../../personalization/models/user_modal.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs; // Observable for binding/showing password
  final privacyPolicy = true.obs; // Observable for privacy policy acceptance
  final email = TextEditingController(); // Controller for email input field
  final username = TextEditingController(); // Controller for username input field
  final lastname = TextEditingController(); // Controller for lastname input field
  final firstname = TextEditingController(); // Controller for firstname input field
  final password = TextEditingController(); // Controller for password input field
  final phoneNumber = TextEditingController(); // Controller for phone number input field
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for form validation

  // SIGNUP
  void signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information', TImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModal(
        id: userCredential.user!.uid,
        firstName: firstname.text.trim(),
        lastName: lastname.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue.',
      );

      // Move to verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      // remove Loader
      TFullScreenLoader.stopLoading();

      // Show some generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}