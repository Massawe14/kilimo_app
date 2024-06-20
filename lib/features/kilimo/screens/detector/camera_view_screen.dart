import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:camera/camera.dart';

import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/maize/scan_controller.dart';
import 'widgets/bounding_box_painter.dart';

class CameraViewScreen extends StatelessWidget {
  const CameraViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final ScanController scanController = Get.put(ScanController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left,
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: const Text('Real-Time Disease Detector'),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.notification,
            ),
            onPressed: () {
              // Handle notification icon action
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
            onPressed: () {
              // Show the popup menu when the icon is clicked
              showPopupMenu(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            if (scanController.isCameraInitialized.value) {
              return Stack(
                children: [
                  CameraPreview(scanController.cameraController),
                  CustomPaint(
                    painter: BoundingBoxPainter(scanController.results),
                    child: Container(),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: darkMode ? TColors.white : TColors.black,
                ),
              );
            }
          }),
          // Error message overlay (optional)
          Obx(() => Visibility(
            visible: scanController.cameraController.value.hasError,
            child: Center(
              child: Text(
                "Camera Error: ${scanController.cameraController.value.errorDescription}",
                style: const TextStyle(
                  color: TColors.error, 
                  fontSize: 16.0
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
