import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TensorFlowService {
  static const platform = MethodChannel('com.example.kilimo_app/tensorflow');

  // Method to load model with FlexDelegate via MethodChannel
  static Future<void> loadModelWithFlexDelegate() async {
    try {
      final result = await platform.invokeMethod('loadModelWithFlexDelegate');
      debugPrint(result); // Should print "Model loaded with FlexDelegate"
    } catch (e) {
      debugPrint("Failed to load model: $e");
    }
  }

  // Method to perform predictions
  static Future<List<double>?> predict(List<List<List<double>>> input) async {
    try {
      final result = await platform.invokeMethod('predict', {
        'input': input,
      });
      return List<double>.from(result); // Convert result to List<double>
    } catch (e) {
      debugPrint("Prediction failed: $e");
      return null; // Return null in case of failure
    }
  }
}
