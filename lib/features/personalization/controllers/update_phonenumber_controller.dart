import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../util/constants/image_strings.dart';
import '../../../util/helpers/network_manager.dart';
import '../../../util/popups/full_screen_loader.dart';
import '../../../util/popups/loaders.dart';
import '../screens/profile/profile_screen.dart';
import 'user_controller.dart';

// Controller to manage user-related functionality.
class UpdatePhoneNumberController extends GetxController {
  static UpdatePhoneNumberController get instance => Get.find();

  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserPhoneNumberFormKey = GlobalKey<FormState>();

  // Init user data when Name Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializeNames() async {
    phoneNumber.text = userController.user.value.phoneNumber;
  }

  Future<void> updateUserPhoneNumber() async {
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
      if (!updateUserPhoneNumberFormKey.currentState!.validate()) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's phone number in the Firestore.
      Map<String, dynamic> phone = {'PhoneNumber': phoneNumber.text.trim()};
      await userRepository.updateSingleField(phone);

      // Update the Rx User Value
      userController.user.value.phoneNumber = phoneNumber.text.trim();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue.',
      );

      // Move to previous Screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      // remove Loader
      TFullScreenLoader.stopLoading();

      // Show some generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  } 
}
