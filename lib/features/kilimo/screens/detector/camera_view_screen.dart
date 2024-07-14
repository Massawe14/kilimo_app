import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/maize/mize_scan_controller.dart';
import 'widgets/bounding_box_painter.dart';

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
                      child: CameraPreview(controller.cameraController!),
                    ),
                    CustomPaint(
                      painter: ObjectDetectionPainter(controller.detectedObjects),
                    ),
                  ],
                )
              : const Center(
                child: Text("Loading Preview...."),
              );
          }
        ),
      ),
    );
  }
}
