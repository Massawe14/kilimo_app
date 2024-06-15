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

      await cameraController.initialize().then((_) {
        cameraController.startImageStream((CameraImage image) {
          if (!isModelRunning.value) {
            detectDisease(image);
          }
        });
      });
    } else {
      debugPrint("Permission denied");
    }
  }

  void initTFLite() async {
    await Tflite.loadModel(
      model: "assets/models/model32.tflite",
      labels: "assets/models/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  Future<void> detectDisease(CameraImage image) async {
    isModelRunning.value = true;

    try {
      var input = preprocessImage(image);

      var output = await Tflite.runModelOnFrame(
        bytesList: input,
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 0,
        imageStd: 255.0,
        numResults: 1,
      );

      if (output != null && output.isNotEmpty) {
        results.assignAll(output);
      } else {
        results.clear();
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to run model: ${e.message}");
    } finally {
      isModelRunning.value = false;
    }
  }

  List<Uint8List> preprocessImage(CameraImage image) {
    List<double> normalizedImage = normalizeImage(image);
    List<Uint8List> reshapedImage = reshapeImage(normalizedImage);
    return reshapedImage;
  }

  List<double> normalizeImage(CameraImage image) {
    List<double> normalized = [];
    final int width = image.width;
    final int height = image.height;

    // Accessing Y-plane (luminance) only for grayscale conversion
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int pixel = image.planes[0].bytes[y * width + x];
        double grayscale = pixel / 255.0; // Normalize to [0, 1]
        normalized.add(grayscale);
      }
    }
    return normalized;
  }

  List<Uint8List> reshapeImage(List<double> image) {
    Float32List floatList = Float32List.fromList(image);
    return [floatList.buffer.asUint8List()];
  }
}
