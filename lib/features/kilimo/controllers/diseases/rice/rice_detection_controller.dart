import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../../util/constants/api_constants.dart';

class RiceDetectionController extends GetxController {
  var imageFile = Rx<File?>(null);
  var detectionResult = Rx<Map<String, dynamic>?>(null);
  var isLoading = false.obs;

  final ImagePicker picker = ImagePicker();

  Future<void> captureImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      await detectDisease();
    }
  }

  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      await detectDisease();
    }
  }

   Future<void> detectDisease() async {
    final url = Uri.parse(APIConstants.tRiceDetectionAPIURL);

    // Print request details for debugging
    debugPrint('URL: $url');
    debugPrint('File path: ${imageFile.value!.path}');

    try {
      if (imageFile.value == null) return;

      isLoading.value = true;

      final request = http.MultipartRequest('POST', url);

      request.fields.addAll({'user_id': '2'});

      request.files.add(
        await http.MultipartFile.fromPath(
          'file', 
          imageFile.value!.path,
        ),
      );

      // Log the request data
      debugPrint('Request data: ${request.files.first.filename}');

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonResponse = json.decode(responseBody);

        // Validate the response structure
        if (jsonResponse.containsKey('results') && jsonResponse['results'].containsKey('boxes') && jsonResponse['results'].containsKey('names')) {
          const JsonEncoder encoder = JsonEncoder.withIndent('  ');
          debugPrint('Response Body: ${encoder.convert(jsonResponse)}');
          detectionResult.value = jsonResponse;
        } else {
          debugPrint('Invalid response structure: $jsonResponse');
          detectionResult.value = null;
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        debugPrint('Response status: ${response.statusCode}');
        debugPrint('Response: $responseBody');
        detectionResult.value = null;
      }
    } catch (e) {
      // Print any errors that occur during the request
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<Map<String, dynamic>> getBoxes(double imageWidth, double imageHeight) {
    if (detectionResult.value == null) return [];
    List<dynamic> boxes = detectionResult.value!['results']['boxes']['xyxy'];
    List<dynamic> confs = detectionResult.value!['results']['boxes']['conf'];
    List<dynamic> cls = detectionResult.value!['results']['boxes']['cls'];
    Map<String, dynamic> names = detectionResult.value!['results']['names'];

    List<Map<String, dynamic>> boxList = [];
    for (int i = 0; i < boxes.length; i++) {
      int classIndex = cls[i].toInt();
      String className = names[classIndex.toString()] ?? 'Unknown';
      double confidence = confs[i];

      // Normalize coordinates
      double left = boxes[i][0] / detectionResult.value!['results']['orig_shape'][1];
      double top = boxes[i][1] / detectionResult.value!['results']['orig_shape'][0];
      double right = boxes[i][2] / detectionResult.value!['results']['orig_shape'][1];
      double bottom = boxes[i][3] / detectionResult.value!['results']['orig_shape'][0];

      boxList.add({
        'box': [left, top, right, bottom],
        'conf': confidence,
        'name': className,
      });
    }
    return boxList;
  }

  Map<String, dynamic>? getHighestConfidenceBox(List<Map<String, dynamic>> boxes) {
    if (boxes.isEmpty) return null;

    boxes.sort((a, b) => b['conf'].compareTo(a['conf']));
    return boxes.first;
  }

  // Clear output when the screen is closed
  void clearOutputOnClose() {
    isLoading.value = false;
    detectionResult.value!.clear();
    imageFile.value = null;
  }
}
