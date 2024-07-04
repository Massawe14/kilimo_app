import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../../../util/popups/loaders.dart';
import '../../controllers/diseases/maize/maize_detection_controller.dart';
import 'widgets/bounding_box_painter.dart';

class MaizeCameraView extends StatefulWidget {
  const MaizeCameraView({super.key});

  @override
  MaizeCameraViewState createState() => MaizeCameraViewState();
}

class MaizeCameraViewState extends State<MaizeCameraView> {
  CameraController? cameraController;
  final MaizeDetectionController detectionController = Get.put(MaizeDetectionController());
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    cameraController = CameraController(camera, ResolutionPreset.high);
    await cameraController!.initialize();
    startImageStream();
    setState(() {}); // Update the UI after camera initialization
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  void startImageStream() {
    cameraController?.startImageStream((CameraImage image) async {
      if (!isProcessing) {
        isProcessing = true;
        try {
          // Convert the CameraImage to a format suitable for the API
          final imageBytes = await convertCameraImageToUint8List(image);

          // Call the API and process the response
          await detectionController.detectDisease(imageBytes);
        } catch (e) {
          TLoaders.errorSnackBar(
            title: 'Error',
            message: e.toString(),
          );
        } finally {
          isProcessing = false;
        }
      }
    });
  }

  Future<Uint8List> convertCameraImageToUint8List(CameraImage image) async {
    // Convert CameraImage to Uint8List (this is a simplified example and may need adjustments)
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final Uint8List bytes = allBytes.done().buffer.asUint8List();
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left,
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: const Text('Maize Disease Detection'),
      ),
      body: Stack(
        children: [
          cameraController == null || !cameraController!.value.isInitialized
            ? const Center(
                child: CircularProgressIndicator()
              )
            : Center(
                child: CameraPreview(cameraController!),
              ),
          Obx(() {
            if (detectionController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (detectionController.detectionResults.isEmpty) {
              return Container();
            }

            return CustomPaint(
              painter: DetectionPainter(detectionController.detectionResults),
            );
          }),
        ],
      ),
    );
  }
}
