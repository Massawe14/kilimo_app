import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../util/constants/api_constants.dart';
import '../../../../../util/popups/loaders.dart';

class MaizeDetectionController extends GetxController {
  var isLoading = false.obs;
  var detectionResults = [].obs;

  Future<void> detectDisease(Uint8List imageBytes) async {
    isLoading.value = true;
    detectionResults.clear();

    final url = Uri.parse(APIConstants.tMaizeDetectionAPIURL);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'image', 
          imageBytes, 
          filename: 'image.jpg'
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      debugPrint("Response: $response");

      if (response.statusCode == 200) {
        debugPrint('Response Body: ${response.body}'); // Print the response body for debugging
        var responseData = response.body;
        var decodedData = jsonDecode(responseData);
        debugPrint("Decoded data: $decodedData");
        detectionResults.addAll(decodedData['results']);
      } else {
        TLoaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to get response from API',
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
