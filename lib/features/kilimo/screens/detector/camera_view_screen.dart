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
      body: Obx(() {
        // Use Obx only to listen to isCameraInitialized.value
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
          return const Center(
            child: Text("Loading Preview..."),
          );
        }
      }),
    );
  }
}
