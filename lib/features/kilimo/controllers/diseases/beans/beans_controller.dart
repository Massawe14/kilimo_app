import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../../../util/constants/api_constants.dart';

class BeansDiagnosisController extends GetxController {
  var isLoading = true.obs;
  final image = Rx<File?>(null);
  var output = [].obs;
  var accuracy = 0.0.obs;

  classifyImage(File file) async {
    final url = Uri.parse(APIConstants.tBeansAPIModel);

    // Create a Map to represent the request payload
    final Map<String, String> requestBody = {
      "image": '"${file.path}"',
    };

    debugPrint("Request: $requestBody");

    try {
      // Send the POST request with the request body as JSON
      final request = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (request.statusCode == 200) {
        // Parse the response JSON and update values accordingly
        final response = jsonDecode(request.body);
        debugPrint("Response: $response");
        output.value = response['output'];
        accuracy.value = response['accuracy'];
        isLoading.value = false;
      } else {
        // Print the response message if status code is not 200
        final resJson = jsonDecode(request.body);
        debugPrint("Meassage: $resJson");
      }
    } catch (e) {
      // Print any errors that occur during the request
      debugPrint('Error: $e');
      isLoading.value = false;
    }
  }
}
