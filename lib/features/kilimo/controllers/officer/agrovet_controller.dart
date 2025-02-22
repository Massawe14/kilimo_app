import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/image_strings.dart';
import '../../../../util/helpers/network_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';
import '../../models/agrovet/agrovet_model.dart';

class AgrovetController extends GetxController {
  static AgrovetController get instance => Get.find();

  // Reactive variables for CSC Picker
  final selectedCountry = ''.obs;
  final selectedState = ''.obs;
  final selectedCity = ''.obs;

  // Text Controllers for input fields
  final fullname = TextEditingController(); 
  final phoneNumber = TextEditingController(); 
  final district = TextEditingController();
  final ward = TextEditingController();

  // Form key for form validation
  GlobalKey<FormState> agrovetFormKey = GlobalKey<FormState>();

  // List to store fetched Agrovets
  RxList<AgrovetModel> agrovetList = <AgrovetModel>[].obs;
  var user = Rx<User?>(null);

  @override
  onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  // Function to fetch Agrovets by user's ward location
  Future<void> fetchAgrovetsByWard() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your internet and try again'
        );
        return;
      }

      // Get the current user's ward
      String userId = user.value!.uid;
      String userWard = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .get()
        .then((doc) => doc['Street']);

      // Query Firestore where ward matches user's ward
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Agrovet')
        .where('ward', isEqualTo: userWard)
        .get();

      // Convert documents into AgrovetModel list
      agrovetList.value = snapshot.docs.map((doc) => AgrovetModel.fromSnapshot(doc)).toList();
      
      // Show success message if data is retrieved
      if (agrovetList.isNotEmpty) {
        TLoaders.successSnackBar(
          title: 'Data Loaded',
          message: 'Agrovets in your ward have been fetched successfully.'
        );
      } else {
        TLoaders.warningSnackBar(
          title: 'No Data',
          message: 'No Agrovets found in your ward.'
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch Agrovets: ${e.toString()}'
      );
    }
  }

  // Register Agrovet
  Future<void> registerAgrovet() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information', 
        TImages.docerAnimation
      );

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'No Internet Connection', 
          message: 'Please check your internet and try again'
        );
        return;
      }

      // Form Validation
      if (!agrovetFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Create Firestore Reference
      final collectionRef = FirebaseFirestore.instance.collection('Agrovet');

      // Prepare Agrovet Data (Without ID)
      final newAgrovet = AgrovetModel(
        id: '', // Will be replaced after getting Firestore ID
        name: fullname.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        country: selectedCountry.value,
        state: selectedState.value,
        city: selectedCity.value,
        district: district.text.trim(),
        ward: ward.text.trim(),
        date: DateTime.now(),
      );

      // Save to Firestore & Get Document ID
      final docRef = await collectionRef.add(newAgrovet.toJson());

      // Update the document with the correct ID
      await docRef.update({'id': docRef.id});

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
        title: 'Agrovet Registered', 
        message: 'Agrovet has been successfully registered'
      );

      // Clear Input Fields After Success
      _clearForm();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Oh Snap', 
        message: 'Failed to register Agrovet: ${e.toString()}'
      );
    }
  }

  // Clear form fields
  void _clearForm() {
    fullname.clear();
    phoneNumber.clear();
    district.clear();
    ward.clear();
    selectedCountry.value = '';
    selectedState.value = '';
    selectedCity.value = '';
  }
}
