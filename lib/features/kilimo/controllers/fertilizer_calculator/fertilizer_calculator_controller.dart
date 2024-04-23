import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FertilizerCalculatorController extends GetxController {
  var selectedCrop = "".obs;
  var selectedUnit = "Acre".obs;
  var plotSize = 1.0.obs;
  var nitrogenController = TextEditingController();
  var phosphorusController = TextEditingController();
  var potassiumController = TextEditingController();

  void calculateFertilizer() {
    // Perform calculation here
    // Save locally
    // Display output
  }

  void resetNutrientQuantities() {
    // Reset nutrient quantities to default
    nitrogenController.clear();
    phosphorusController.clear();
    potassiumController.clear();
  }

  void saveNutrientQuantities() {
    // Save nutrient quantities
    // You can access the values using:
    nitrogenController.text; 
    phosphorusController.text; 
    potassiumController.text;
  }
}
