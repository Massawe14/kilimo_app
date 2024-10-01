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
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false, // disable popping with back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Center( // Use Center widget to center the content
            child: Column(
              mainAxisSize: MainAxisSize.min, // Make the column take only the required height
              children: [
                // Instead of fixed height, use a flexible spacing
                TAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
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