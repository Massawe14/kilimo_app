import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilimo_app/util/constants/colors.dart';
import 'package:kilimo_app/util/helpers/helper_functions.dart';

import '../../common/widgets/loaders/animation_loader.dart';

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
          child: Column(
            children: [
              const SizedBox(height: 250), // Adjust the spacing as needed
              TAnimationLoaderWidget(text: text, animation: animation),
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