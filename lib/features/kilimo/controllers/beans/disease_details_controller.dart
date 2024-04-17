import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../models/disease_model.dart';

class DiseaseDetailsController extends GetxController {
  final String diseaseName;
  Rx<Disease?> disease = Rx(null); // Reactive using GetX
  RxBool isLoading = RxBool(false); // Reactive loading state

  DiseaseDetailsController({required this.diseaseName});

  @override
  void onInit() {
    super.onInit();
    _fetchDiseaseDetails();
  }

  void _fetchDiseaseDetails() async {
    isLoading.value = true; // Start loading
    try {
      var diseaseData = Hive.box<Disease>('diseases').get(diseaseName);
      disease.value = diseaseData;
    } catch (error) {
      // Handle the error here (e.g., show an error message)
      debugPrint("Error fetching disease details: $error");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
