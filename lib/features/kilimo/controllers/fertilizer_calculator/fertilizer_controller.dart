import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/popups/loaders.dart';
import '../../models/fertilizer/calculation_modal.dart';

class FertilizerController extends GetxController {
  // Rx variables for reactive updates
  RxString selectedCrop = ''.obs;
  
  final plotSizeController = TextEditingController();
  final nitrogenController = TextEditingController();
  final phosphorusController = TextEditingController();
  final potassiumController = TextEditingController();

  var fertilizerNeeded = 0.0.obs;
  var user = Rx<User?>(null);
  var calculationHistory = <CalculationModal>[].obs;

  // Add these properties
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
    fetchCalculationHistory();
  }

  @override
  void dispose() {
    plotSizeController.clear();
    nitrogenController.clear();
    phosphorusController.clear();
    potassiumController.clear();
    super.dispose();
  }

  void calculateFertilizer() {
    if (user.value == null) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'User not authenticated',
      );
      return;
    }

    double plotSize = double.parse(plotSizeController.text);
    double nitrogen = double.parse(nitrogenController.text);
    double phosphorus = double.parse(phosphorusController.text);
    double potassium = double.parse(potassiumController.text);

    // Simple formula to calculate fertilizer needed
    double totalFertilizer = (nitrogen + phosphorus + potassium) * (plotSize / 10);
    fertilizerNeeded.value = totalFertilizer;

    try {
      fetchUserDetailsAndSave(plotSize, nitrogen, phosphorus, potassium, totalFertilizer);
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error', 
        message: 'Failed to save calculation'
      );
    }
  }

  Future<void> fetchUserDetailsAndSave(double plotSize, double nitrogen, double phosphorus, double potassium, double totalFertilizer) async {
    String userId = user.value!.uid;

    // Fetch user details from Firestore (assuming user details are stored in a collection 'users')
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    String userName = userDoc['UserName'];

    // Create a CalculationModal instance
    CalculationModal calculation = CalculationModal(
      id: '',
      cropType: selectedCrop.value,
      nitrogen: nitrogen,
      phosphorus: phosphorus,
      potassium: potassium,
      plotSize: plotSize,
      userId: userId,
      userName: userName,
      totalFertilizer: totalFertilizer,
      date: DateTime.now(),
    );

    // Save the calculation to Firestore
    FirebaseFirestore.instance.collection('fertilizer_calculations').add(calculation.toJson());
  }

  Future<void> fetchCalculationHistory() async {
    if (user.value == null) return;

    try {
      String userId = user.value!.uid;

      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('fertilizer_calculations')
        .where('UserId', isEqualTo: userId)
        .orderBy('Date', descending: true)
        .get();

      calculationHistory.value = snapshot.docs
        .map((doc) => CalculationModal.fromSnapshot(doc))
        .toList();

      debugPrint('Fetched ${calculationHistory.length} calculations');
    } catch (e) {
      debugPrint('Error fetching calculation history: $e');
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch calculation history',
      );
    }
  }

  // Delete Post by ID
  Future<void> deleteCalculationHistory(String postId) async {
    try {
      await FirebaseFirestore.instance.collection("fertilizer_calculations").doc(postId).delete();
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }
}
