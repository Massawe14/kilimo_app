// controllers/camera_controller_x.dart
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../../util/constants/api_constants.dart';

class RealTimeDetectorController extends GetxController {
  final CameraDescription cameraDescription;
  RealTimeDetectorController(this.cameraDescription);

  CameraController? cameraController;
  final prediction = ''.obs;

  Future<void> initCamera() async {
    cameraController = CameraController(cameraDescription, ResolutionPreset.medium);
    await cameraController?.initialize();
    startImageStream();
  }

  void startImageStream() {
    cameraController?.startImageStream((CameraImage image) async {
      if (image.planes.length != 3) return;

      final bytes = await convertYUV420toImageColor(image);
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/image.jpg';
      final file = File(imagePath)..writeAsBytesSync(bytes);

      final url = Uri.parse(APIConstants.tBeansAPIModel);

      final request = http.MultipartRequest(
        'POST',
        url,
      );
      
      request.files.add(
        http.MultipartFile(
          'image',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: 'image.jpg',
        ),
      );

      final response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final result = jsonDecode(respStr);
        prediction.value = result.toString();
      }
    });
  }

  Future<Uint8List> convertYUV420toImageColor(CameraImage image) async {
    final int width = image.width;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;
    final img = Uint8List(width * height * 3 ~/ 2);
    final uBuffer = image.planes[1].bytes;
    final vBuffer = image.planes[2].bytes;

    for (int y = 0; y < height; y++) {
      int uvOffset = uvRowStride * (y >> 1);
      for (int x = 0; x < width; x++) {
        int uvIndex = uvOffset + (x >> 1) * uvPixelStride;
        img[uvIndex] = uBuffer[uvIndex];
        img[uvIndex] = vBuffer[uvIndex];
      }
    }
    return img;
  }
}
