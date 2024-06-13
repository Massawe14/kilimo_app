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

  var x = 0.0;
  var y = 0.0;
  var w = 0.0;
  var h = 0.0;
  var label = "";

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

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();

      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0 && !isModelRunning.value) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });
      isCameraInitialized(true);
      update();
    } else {
      debugPrint("Permission denied");
    }
  }

  initTFLite() async {
    await Tflite.loadModel(
      model: "assets/models/yolov2_tiny.tflite",
      labels: "assets/models/yolov2_tiny.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  objectDetector(CameraImage image) async {
    if (isModelRunning.value) return;
    isModelRunning.value = true;

    try {
      var results = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((e) => e.bytes).toList(),
        asynch: true,
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 1,
        rotation: 90,
        threshold: 0.4,
      );

      if (results != null && results.isNotEmpty) {
        var detectedObject = results.first;

        // Assume the detectedObject contains the required data
        // Extract relevant data
        if (detectedObject is Map<String, dynamic> && detectedObject.containsKey('rect')) {
          var rect = detectedObject['rect'];
          if (rect is Map<String, dynamic> && rect.containsKey('x') && rect.containsKey('y') && rect.containsKey('w') && rect.containsKey('h')) {
            label = detectedObject['detectedClass'].toString();
            h = rect['h'];
            w = rect['w'];
            x = rect['x'];
            y = rect['y'];
            debugPrint("Detection: $detectedObject");
          } else {
            debugPrint("Unexpected shape: $detectedObject");
          }
        } else {
          debugPrint("Unexpected shape: $detectedObject");
        }
      } else {
        debugPrint("No detection results.");
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to run model: ${e.message}");
    } finally {
      isModelRunning.value = false;
      update();
    }
  }
}
