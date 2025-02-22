import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../util/constants/image_strings.dart';
import '../../../../util/helpers/network_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';
import '../../models/recommendation/recommendation_model.dart';

class RecommendationController extends GetxController {
  static RecommendationController get instance => Get.find();

  // Text Controllers for input fields
  final diseaseName = TextEditingController(); 
  final symptoms = TextEditingController();
  final treatments = TextEditingController();
  final preventiveMeasures = TextEditingController();

  final imageFile = Rxn<File>(); // Use Rxn for better null handling
  var user = Rx<User?>(null);
  Rx<RecommendationModel> selectedPost = RecommendationModel.empty().obs;
  final isImageUploaded = false.obs;
  final isLoading = false.obs; 

  // Form key for form validation
  GlobalKey<FormState> recommendationFormKey = GlobalKey<FormState>();

  @override
  onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  // Cleare form fields
  void clearFormFields() {
    diseaseName.clear();
    symptoms.clear();
    treatments.clear();
    preventiveMeasures.clear();
    imageFile.value = null;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      isImageUploaded.value = true; // Mark image as uploaded
    }
  }

  Future<String> uploadImageToFirebase(String path, File image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.toString());
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  // Save Recommendation
  void saveRecommendation() async {
    // Form Validation
    if (!recommendationFormKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    if (user.value == null) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'User not authenticated',
      );
      return;
    }
    try {
      // Start Loading
      isLoading.value = true; // Show loading indicator
      TFullScreenLoader.openLoadingDialog('We are processing your information', TImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      String userId = user.value!.uid;

      // Check if the image is uploaded
      if (imageFile.value == null) {
        TLoaders.warningSnackBar(
          title: 'Image not uploaded',
          message: 'Please upload an image of your crop before submitting the post',
        );
        return;
      }

      // Upload image to Firebase
      final imageUrl = await uploadImageToFirebase('Recommendations/Images/', imageFile.value!);

      // Create Firestore Reference
      final collectionRef = FirebaseFirestore.instance.collection('Recommendations');

      // Prepare Recommendation Data (Without ID)
      final newRecommendation = RecommendationModel(
        id: '', // Will be replaced after getting Firestore ID
        userId: userId,
        name: diseaseName.text.trim(),
        symptoms: symptoms.text.trim().split(','),
        treatments: treatments.text.trim().split(','),
        preventiveMeasures: preventiveMeasures.text.trim().split(','),
        image: imageUrl,
        date: DateTime.now(),
      );

      // Save to Firestore & Get Document ID
      final docRef = await collectionRef.add(newRecommendation.toJson());

      // Update the document with the correct ID
      await docRef.update({'id': docRef.id});

      // Reset image
      imageFile.value = null;
      isImageUploaded.value = false;

      // Clear form fields
      clearFormFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Snack Bar
      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Recommendation saved successfully',
      );
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Something went wrong posting your problem: $e',
      );
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
