import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';

class MaizeScanController extends GetxController {
  CameraController? cameraController;
  RxBool isDetecting = false.obs;
  var isCameraInitialized = false.obs;
  RxList<dynamic> detectedObjects = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    loadModel();
  }

  void initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController!.initialize();
    cameraController!.startImageStream((image) {
      if (!isDetecting.value) {
        isDetecting.value = true;
        runModelOnFrame(image);
      }
    });
    isCameraInitialized(true);
    update();
  }

  void loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/models/quantized_maize_2.tflite',
        labels: 'assets/models/labels.txt',
        useGpuDelegate: false,
        numThreads: 1,
        isAsset: true,
      );
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  void runModelOnFrame(CameraImage image) async {
    try {
      // Preprocess camera image
      Uint8List input = preprocessCameraImage(image, [1, 3, 320, 320]);

      // Prepare input data as required by the model
      var output = await Tflite.runModelOnBinary(
        binary: input,
        numResults: 2100,
        threshold: 0.2,
        asynch: true,
      );

      // Handle recognition results
      if (output != null && output.isNotEmpty) {
        // Print or log the recognitions for debugging
        debugPrint('Recognitions: $output');
        detectedObjects.value = output;
      } else {
        debugPrint('No recognitions found');
        detectedObjects.clear();
      }
    } catch (e) {
      debugPrint('Error running model on frame: $e');
    } finally {
      isDetecting.value = false;
    }
  }

  Uint8List preprocessCameraImage(CameraImage image, List<int> inputShape) {
    final int width = image.width;
    final int height = image.height;
    final int targetHeight = inputShape[2];
    final int targetWidth = inputShape[3];
    final int channels = inputShape[1];

    // Create a buffer for the resized RGB image
    var resizedBytes = Uint8List(targetHeight * targetWidth * channels);

    // Process YUV420_888 image data and fill resized RGB buffer
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

        // Set RGB values in resizedBytes
        final int targetX = x * targetWidth ~/ width;
        final int targetY = y * targetHeight ~/ height;
        final int targetIndex = (targetY * targetWidth + targetX) * channels;

        resizedBytes[targetIndex] = r;
        resizedBytes[targetIndex + 1] = g;
        resizedBytes[targetIndex + 2] = b;
      }
    }

    // Convert to the required input format [1, 3, 320, 320]
    var inputBuffer = Uint8List(1 * channels * targetHeight * targetWidth);
    var bufferIndex = 0;

    for (int c = 0; c < channels; c++) {
      for (int y = 0; y < targetHeight; y++) {
        for (int x = 0; x < targetWidth; x++) {
          inputBuffer[bufferIndex++] = resizedBytes[(y * targetWidth + x) * channels + c];
        }
      }
    }

    return inputBuffer;
  }

  @override
  void onClose() {
    cameraController?.dispose();
    Tflite.close();
    super.onClose();
  }
}
