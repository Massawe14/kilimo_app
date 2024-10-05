import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class TFullScreenLoader {
  // Open a full-screen loading with a given text and animation
  // This method dosen't return anything
  // Parameters:
  //   - text : The text to be displayed in the loading dialog
  //   - animation : The lottie aniamtion to be shown
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialog
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, // Disable popping with back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 100), // Adjust the spacing as needed
              TAnimationLoaderWidget(text: text, animation: animation), // Display loading animation
            ],
          ),
        ),
      ),
    );
  }

  // Stop the currently open loading dialog.
  // This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}