import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/boxes.dart';
import '../../models/disease.dart';

class DiseaseDetailsController extends GetxController {
  final String diseaseName;
  RxList<Disease> diseases = RxList<Disease>(); // Reactive list of diseases
  RxBool isLoading = true.obs; // Reactive loading state

  DiseaseDetailsController({required this.diseaseName});

  @override
  void onInit() {
    super.onInit();
    _fetchDiseaseDetails();
  }

  void _fetchDiseaseDetails() async {
    try {
      // Fetch all disease data from the Hive box
      final allDiseases = diseasesBox.values.toList();
      
      // Filter the diseases based on the disease name
      final filteredDiseases = allDiseases.where((disease) => disease.name == diseaseName).toList();
      
      // Update the diseases list with filtered data
      diseases.value = filteredDiseases;
    } catch (error) {
      // Handle the error here (e.g., show an error message)
      debugPrint("Error fetching disease details: $error");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
