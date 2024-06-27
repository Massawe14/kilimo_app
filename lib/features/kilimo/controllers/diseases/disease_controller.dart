import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../util/popups/loaders.dart';
import '../../models/disease/disease_model.dart';

class DiseaseController extends GetxController {
  final isLoading = false.obs;
  Rx<DiseaseModal> disease = DiseaseModal.empty().obs;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void getDiseaseDetails(String diseaseName) async {
    isLoading(true);
    try {
      final snapshot = await _db.collection('Diseases').doc(diseaseName).get();
      if (snapshot.exists) {
        debugPrint('Snapshot data: ${snapshot.data()}'); // Log the snapshot data
        disease.value = DiseaseModal.fromSnapshot(snapshot);
        debugPrint("Disease data: ${disease.value}");
      } else {
        // Handle case where disease is not found
        TLoaders.errorSnackBar(
          title: 'Error',
          message: 'Disease not found',
        );
      }
    } catch (e) {
      debugPrint("Error fetching disease details: $e");
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch disease details.',
      );
      disease(DiseaseModal.empty());
    } finally {
      // Ensure isLoading is set to false after fetching completes or fails
      isLoading(false);
    }
  }
}