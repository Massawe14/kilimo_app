import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';

class MaizeScanController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;

  var x = 0.0;
  var y = 0.0;
  var h = 0.0;
  var w = 0.0;

  var label = "";
  var isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    initCamera();
    initTFliteModel();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
    Tflite.close();
  }

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();

      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await cameraController.initialize().then((_) {
        cameraController.startImageStream((image) {
          if (cameraCount % 5 == 0) {
            cameraCount = 0;
            if (!isProcessing.value) {
              isProcessing(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                objectDetector(image);
              });
            }
          }
          cameraCount++;
          update();
        });
      });
      isCameraInitialized(true);
      update();
    } else {
      debugPrint("Permission denied");
    }
  }

  initTFliteModel() async {
    await Tflite.loadModel(
      model: "assets/models/maize_detection_model.tflite",
      labels: "assets/models/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  objectDetector(CameraImage image) async {
    try {
      // Convert the CameraImage to a Float32List
      Float32List input = convertCameraImageToFloat32List(image, 256, 256);

      var detector = await Tflite.runModelOnFrame(
        bytesList: [input.buffer.asUint8List()],
        asynch: true,
        imageHeight: 256,
        imageWidth: 256,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 4,
        rotation: 90,
        threshold: 0.4,
      );

      if (detector != null && detector.isNotEmpty) {
        var ourDetectedObject = detector.first;
        if (ourDetectedObject['confidenceClass'] * 100 > 45) {
          label = ourDetectedObject['detectedClass'].toString();
          h = ourDetectedObject['rect']['h'] ?? 0.0;
          w = ourDetectedObject['rect']['w'] ?? 0.0;
          x = ourDetectedObject['rect']['x'] ?? 0.0;
          y = ourDetectedObject['rect']['y'] ?? 0.0;
        }
        update();
        debugPrint("Result is $detector");
      }
    } catch (e) {
      debugPrint("Failed to run model: $e");
    } finally {
      isProcessing(false);
    }
  }

  Float32List convertCameraImageToFloat32List(CameraImage image, int targetWidth, int targetHeight) {
    final int width = image.width;
    final int height = image.height;

    // Create a Float32List with the target dimensions
    Float32List float32List = Float32List(targetWidth * targetHeight * 3);

    // Process the YUV420 image data and fill the Float32List
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int uvIndex = (x ~/ 2) + (y ~/ 2) * (width ~/ 2);
        final int index = y * width + x;

        final int yp = image.planes[0].bytes[index];
        final int up = image.planes[1].bytes[uvIndex] - 128;
        final int vp = image.planes[2].bytes[uvIndex] - 128;

        // Convert YUV to RGB
        final int r = (yp + vp * 1.370705).clamp(0, 255).toInt();
        final int g = (yp - up * 0.337633 - vp * 0.698001).clamp(0, 255).toInt();
        final int b = (yp + up * 1.732446).clamp(0, 255).toInt();

        // Normalize the RGB values and add to Float32List
        final int targetX = x * targetWidth ~/ width;
        final int targetY = y * targetHeight ~/ height;
        final int targetIndex = (targetY * targetWidth + targetX) * 3;

        float32List[targetIndex] = (r - 127.5) / 127.5;
        float32List[targetIndex + 1] = (g - 127.5) / 127.5;
        float32List[targetIndex + 2] = (b - 127.5) / 127.5;
      }
    }

    return float32List;
  }
}
