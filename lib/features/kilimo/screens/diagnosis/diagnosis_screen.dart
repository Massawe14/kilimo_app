import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  DiagnosisScreenState createState() => DiagnosisScreenState();
}

class DiagnosisScreenState extends State<DiagnosisScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _resultController = TextEditingController();
  final RxString _historyKey = 'history'.obs;
  final GetStorage _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model/resnet_model_beans.tflite',
      labels: 'assets/model/labels.txt',
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      classifyImage(File(pickedFile.path));
    }
  }

  Future<void> classifyImage(File image) async {
    final List<dynamic>? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.2,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      final String result = recognitions[0]['label'];
      _resultController.text = result;
      showResultDialog(result);
      saveToHistory(result);
    }
  }

  void saveToHistory(String result) {
    final List<String> history = _storage.read(_historyKey.value) ?? [];
    history.insert(0, result);
    _storage.write(_historyKey.value, history);
  }

  void showResultDialog(String result) {
    Get.defaultDialog(
      title: 'Diagnosis Result',
      content: Text('The result is: $result'),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.accent,
        title: const Text('Diagnosis'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.gallery),
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.camera), 
                child: const Text('Take Picture'),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: _resultController,
                decoration: const InputDecoration(labelText: 'Diagnosis Result'),
                readOnly: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}

