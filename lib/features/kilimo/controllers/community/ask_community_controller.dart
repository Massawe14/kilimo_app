import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';

import '../../models/community/community.dart';

class AskCommunityController extends GetxController {
  List<String> crops = ['Beans', 'Maize', 'Cassava', 'Rice'];
  late String selectedCrop = '';
  late File selectedImage = File('');
  final problem = TextEditingController();
  final problemDescription = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final picker = ImagePicker();

  @override
  void onClose() {
    problem.dispose();
    problemDescription.dispose();
    super.onClose();
  }

  // Method to set selected crop
  void setSelectedCrop(String crop) {
    selectedCrop = crop;
    update(); // Notify UI of changes
  }

  // Method to pick image from gallery or camera
  void pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      update(); // Notify UI of changes
    } else {
      showSnackBar('Image selection cancelled');
    }
  }

  // Method to submit data to Realm database
  void submitData() async {
    if (_validateData()) {
      var config = Configuration.local([Community.schema]);
      var realm = Realm(config);

      var communityData = Community(
        ObjectId(), // Assuming ObjectId is required as the first argument
        selectedCrop,
        problem.text,
        problemDescription.text,
        DateTime.now(),
        image: selectedImage.path,
        location: '',
        profileImage: '',
      );

      try {
        realm.write(() {
          realm.add(communityData);
        });

        _resetForm();
        showSnackBar('Data submitted successfully');
      } catch (e) {
        debugPrint('Error submitting data: $e');
        showSnackBar('Failed to submit data. Please try again.');
      }
    } else {
      showSnackBar('Please fill in all fields');
    }
  }

  // Method to validate form data
  bool _validateData() {
    return selectedCrop.isNotEmpty &&
      problem.text.isNotEmpty &&
      problemDescription.text.isNotEmpty;
  }

  // Method to reset form fields
  void _resetForm() {
    selectedCrop = '';
    selectedImage;
    problem.clear();
    problemDescription.clear();
    update(); // Notify UI of changes
  }

  // Method to show a SnackBar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
