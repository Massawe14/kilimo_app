import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';

class ScanController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;
  var isModelRunning = false.obs;

  var results = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    initCamera();
    initTFLite();
  }

  @override
  void dispose() {
    cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  void initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();

      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      cameraController.addListener(() {
        if (cameraController.value.isInitialized && !isModelRunning.value) {
          isCameraInitialized.value = true;
        }
      });

      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0 && !isModelRunning.value) {
            cameraCount = 0;
            detectDisease(image);
          }
        });
        isCameraInitialized(true);
      });
    } else {
      debugPrint("Permission denied");
    }
  }

  initTFLite() async {
    await Tflite.loadModel(
      model: "assets/models/model32.tflite",
      labels: "assets/models/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  Future<void> detectDisease(CameraImage image) async {
    if (isModelRunning.value) return;

    isModelRunning(true);

    try {
      var input = preprocessImage(image);

      var output = await Tflite.runModelOnFrame(
        bytesList: input,
        imageHeight: 320,
        imageWidth: 320,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 5,
        threshold: 0.3,
      );

      if (output != null && output.isNotEmpty) {
        results.value = output;
      } else {
        results.clear();
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to run model: ${e.message}");
    } finally {
      isModelRunning(false);
    }
  }

  List<Uint8List> preprocessImage(CameraImage image) {
    // Prepare input buffer for the model
    var input = Float32List(320 * 320 * 3);
    int pixelIndex = 0;

    final int width = image.width;
    final int height = image.height;

    // Convert YUV420 image to RGB888 and normalize
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        int pixel = _getYUV420Pixel(image, j, i);
        input[pixelIndex++] = ((pixel >> 16 & 0xFF) - 127.5) / 127.5;
        input[pixelIndex++] = ((pixel >> 8 & 0xFF) - 127.5) / 127.5;
        input[pixelIndex++] = ((pixel & 0xFF) - 127.5) / 127.5;
      }
    }

    return [input.buffer.asUint8List()];
  }

  int _getYUV420Pixel(CameraImage image, int x, int y) {
    final int uvIndex = image.width * (y ~/ 2) + (x ~/ 2) * 2;
    final int yp = image.planes[0].bytes[y * image.width + x];
    final int up = image.planes[1].bytes[uvIndex];
    final int vp = image.planes[2].bytes[uvIndex];
    return _convertYUV2RGB(yp, up, vp);
  }

  int _convertYUV2RGB(int yp, int up, int vp) {
    int r = ((yp + vp * 1436 / 1024 - 179).clamp(0, 255)).toInt();
    int g = ((yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91).clamp(0, 255)).toInt();
    int b = ((yp + up * 1814 / 1024 - 227).clamp(0, 255)).toInt();
    return (r << 16) | (g << 8) | b;
  }
}
