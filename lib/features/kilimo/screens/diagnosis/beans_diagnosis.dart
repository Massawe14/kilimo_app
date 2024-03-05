import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

import '../../../../data/services/classifier.dart';
import '../../../../util/constants/enums.dart';

class BeansDiagnosisScreen extends StatefulWidget {
  const BeansDiagnosisScreen({super.key});

  @override
  BeansDiagnosisScreenState createState() => BeansDiagnosisScreenState();
}

class BeansDiagnosisScreenState extends State<BeansDiagnosisScreen> {
  File? _selectedImageFile; // Instantiate your classifier
  late Classifier _classifier;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load classifier when the widget initializes
    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    // Load your classifier
    final classifier = await Classifier.loadWith(
      labelsFileName: 'assets/model/labels.txt', // Replace with your actual file path
      modelFileName: 'assets/model/resnet_model_beans.tflite', // Replace with your actual file path
    );

    setState(() {
      _classifier = classifier;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    // #1 
    final pickedFile = await _picker.pickImage(source: source);

    // #2 
    if (pickedFile == null) {
      return;
    }

    // #3 
    final imageFile = File(pickedFile.path);

    // Display picked image in a Card
    setState(() {
      _selectedImageFile = imageFile;
    });

    // Analyze the picked image
    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) async {
    // #1
    final decodedImage = img.decodeImage(image.readAsBytesSync());

    // #2
    final resultCategory = _classifier.predict(decodedImage as Image);

    // #3
    final result = resultCategory.score >= 0.8
      ? ResultStatus.found
      : ResultStatus.notFound;

    // Show loading widget while processing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Processing Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );

    try {
      // Simulate processing time (replace with actual processing logic)
      await Future.delayed(const Duration(seconds: 2));

      // Dismiss loading widget
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Handle potential errors during processing
      debugPrint('Error during processing: $e');

      // Dismiss loading widget
      if (mounted) {
        Navigator.of(context).pop();
      }
      
      return;
    }

    // Display result in pop-up dialog
    _showResultDialog(result as String, resultCategory.label, resultCategory.score * 100);
  }
  
  void _showResultDialog(String result, String label, double accuracy) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Result: $result'),
              Text('Label: $label'),
              Text('Accuracy: ${accuracy.toStringAsFixed(2)}%'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Processing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImageFile != null
              ? Card(
                  elevation: 5,
                  child: Image.file(_selectedImageFile!),
                )
              : Container(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _onPickPhoto(ImageSource.gallery),
              child: const Text('Pick Photo from Gallery'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _onPickPhoto(ImageSource.camera),
              child: const Text('Capture Photo from Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
