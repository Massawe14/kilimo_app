import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kilimo_app/data/repositories/authentication/authentication_repository.dart';
import 'package:kilimo_app/util/constants/image_strings.dart';

import '../../../../util/helpers/network_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Variables
  final localStorage = GetStorage();
  final hidePassword = true.obs; // Observable for binding/showing password
  final rememberMe = false.obs; // Observable for remember me acceptance
  final email = TextEditingController(); // Controller for email input field
  final password = TextEditingController(); // Controller for password input field
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(); // Form key for form validation

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  // Email and Password login
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.docerAnimation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email & Password Authentication
      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}