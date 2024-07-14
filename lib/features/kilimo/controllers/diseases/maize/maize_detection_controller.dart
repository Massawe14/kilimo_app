import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../../util/constants/api_constants.dart';

class MaizeDetectionController extends GetxController {
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
    final url = Uri.parse(APIConstants.tMaizeDetectionAPIURL);

    // Print request details for debugging
    debugPrint('URL: $url');
    debugPrint('File path: ${imageFile.value!.path}');

    try {
      if (imageFile.value == null) return;

      isLoading.value = true;

      final request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', 
          imageFile.value!.path,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonResponse = json.decode(responseBody);

        // Pretty print JSON response
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        debugPrint('Response Body: ${encoder.convert(jsonResponse)}');

        detectionResult.value = jsonResponse;
      } else {
        detectionResult.value = null;
        // Print the response message if status code is not 200
        debugPrint("Response status: ${response.statusCode}");
        debugPrint("Response: $response");
        debugPrint('Failed to get detection results');
      }
    } catch (e) {
      // Print any errors that occur during the request
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<Map<String, dynamic>> getBoxes() {
    if (detectionResult.value == null) return [];
    List<dynamic> boxes = detectionResult.value!['results']['boxes']['xyxy'];
    List<dynamic> confs = detectionResult.value!['results']['boxes']['conf'];
    List<dynamic> cls = detectionResult.value!['results']['boxes']['cls'];
    Map<String, dynamic> names = detectionResult.value!['results']['names'];

    List<Map<String, dynamic>> boxList = [];
    for (int i = 0; i < boxes.length; i++) {
      int classIndex = cls[i].toInt();
      String className = names[classIndex.toString()] ?? 'Unknown';
      boxList.add({
        'box': boxes[i],
        'conf': confs[i],
        'name': className,
      });
    }
    return boxList;
  }
}
