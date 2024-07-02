import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/maize/mize_scan_controller.dart';

class CameraViewScreen extends StatelessWidget {
  const CameraViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Iconsax.arrow_left,
              color: darkMode ? TColors.white : TColors.black,
            ),
          ),
          title: const Text('Real-Time Disease Detector'),
        ),
        body: GetBuilder<MaizeScanController>(
          init: MaizeScanController(),
          builder: (controller) {
            return controller.isCameraInitialized.value 
              ? Stack(
                  children: [
                    Center(
                      child: CameraPreview(controller.cameraController)
                    ),
                    if (controller.label.isNotEmpty)
                      Positioned(
                        left: controller.x * context.width,
                        top: controller.y * context.height,
                        width: controller.w * context.width,
                        height: controller.h * context.height,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: TColors.accent, width: 2.0),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: TColors.accent.withOpacity(0.7),
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                controller.label,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ) 
              : const Center(
                  child: Text("Loading Preview..."),
                );
          }
        ),
      ),
    );
  }
}
