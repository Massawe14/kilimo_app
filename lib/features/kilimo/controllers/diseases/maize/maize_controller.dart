import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // For MediaType

import '../../../../../util/constants/api_constants.dart';

class MaizeDiagnosisController extends GetxController {
  var isLoading = true.obs;
  final image = Rx<File?>(null);
  var output = <dynamic>[].obs; // Ensure output is always initialized as a list
  var accuracy = 0.0.obs;

  classifyImage(File file) async {
    final url = Uri.parse(APIConstants.tMaizeAPIModel);

    // Print request details for debugging
    debugPrint('URL: $url');
    debugPrint('File path: ${file.path}');

    try {
      // Create a multipart request
      final request = http.MultipartRequest('POST', url);

      // Add the file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // The name field for the file in the form
          file.path,
          contentType: MediaType('image', 'jpeg'), // Adjust content type as necessary
        ),
      );

      // Send the request and get the response
      final response = await request.send();

      // Read the response
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(responseString) as Map<String, dynamic>;

        debugPrint("Response: $responseJson");

        // Find the disease with the highest accuracy
        MapEntry<String, dynamic> maxAccuracyDisease = responseJson.entries.reduce(
          (a, b) => (b.value is double && b.value > a.value) ? b : a,
        );

        debugPrint("Max Accuracy Disease: ${maxAccuracyDisease.key}");

        // Set the output and accuracy values based on the disease with the maximum accuracy
        output.value = [
          {
            'label': maxAccuracyDisease.key, 
            'accuracy': maxAccuracyDisease.value
          }
        ];
        accuracy.value = maxAccuracyDisease.value;
      } else {
        // Print the response message if status code is not 200
        debugPrint("Response status: ${response.statusCode}");
        debugPrint("Response: $responseString");
      }
    } catch (e) {
      // Print any errors that occur during the request
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
