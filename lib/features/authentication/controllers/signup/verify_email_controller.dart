import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/text_strings.dart';
import '../../../../util/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // Send Email whenever verify Screen appears & Set Timer for auto redirect.
  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerForAutoRedirect();
  }

  // Send Email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Timer to automatically redirect on Email verification.
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1), 
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              image: TImages.successfullyRegisterAnimation, 
              title: TTexts.yourAccountCreatedTitle, 
              subTitle: TTexts.yourAccountCreatedSubTitle, 
              onPressed: () => AuthenticationRepository.instance.screenRedirect(),
            )
          );
        }
      }
    );
  }

  // Manually Check if Email verified
  checkEmailVerificationStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: TImages.successfullyRegisterAnimation, 
          title: TTexts.yourAccountCreatedTitle, 
          subTitle: TTexts.yourAccountCreatedSubTitle, 
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        )
      );
    }
  }
}