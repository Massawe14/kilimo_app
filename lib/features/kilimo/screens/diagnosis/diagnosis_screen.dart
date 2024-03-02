import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';


class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key, 
  this.modelPath = 'assets/model/resnet_model_beans.tflite', 
  this.labelsPath = 'assets/model/labels.txt', 
  });

  final String modelPath; // Path to the TensorFlow Lite model file
  final String labelsPath; // Path to the labels.txt file

  @override
  DiagnosisScreenState createState() => DiagnosisScreenState();
}

class DiagnosisScreenState extends State<DiagnosisScreen> {
  File? _imageFile;
  List<String>? _labels;
  List<dynamic>? _results;

  // final TFLiteService _tfliteService = TFLiteService();

  Future<void> _loadLabels() async {
    var labelsFile = File(widget.labelsPath).openRead();
    var lines = await labelsFile.transform(utf8.decoder).toList(); // Convert stream to list of strings
    _labels = lines;
  }

  Future<void> _classifyImage() async {
    if (_imageFile == null) return;

    var interpreter = await Interpreter.fromAsset(widget.modelPath);

    var inputTensor = interpreter.getInputTensor(0); // Access input tensor using getInputTensor
    var inputShape = inputTensor.shape; // Get input shape from the tensor
    var inputSize = inputShape[1] * inputShape[2];
    var probabilities = List<double>.filled(inputShape[0], 0);

    var image = await _loadImage(_imageFile!, inputSize); // Pass inputSize

    interpreter.run(image, probabilities);

    setState(() {
      _results = probabilities;
    });
  }

  Future<List<int>> _loadImage(File imageFile, int inputSize) async {
    var imageBytes = await imageFile.readAsBytes();
    var decodedBytes = await decodeImageFromList(imageBytes);

    // Access image data using toByteData
    var imageData = await decodedBytes.toByteData(); 

    // Convert image data to list of floats
    var img = convertImageToFloat32(imageData!, inputSize);
    return img;
  }

  List<int> convertImageToFloat32(ByteData imageData, int size) {
    var floatList = Float32List.view(imageData.buffer); // Access bytes as Float32List
    return floatList.buffer.asUint8List(); // Convert back to Uint8List
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _imageFile = pickedFile as File?;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLabels(); // Load labels on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _imageFile != null
            ? Image.file(_imageFile!)
            : const Text('No image selected'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text('Capture Image'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Choose Image'),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: _imageFile != null ? _classifyImage : null,
          child: const Text('Classify Image'),
        ),
        ElevatedButton(
          onPressed: _results != null ? _showImageInfoDialog : null,
          child: const Text('Show Result'),
        ),
      ],
    );
  }

  void _showImageInfoDialog() {
    if (_results == null || _labels == null) return;

    var topResultIndex = _results!.indexOf(_results!.reduce((a, b) => a > b ? a : b));
    var topProbability = _results![topResultIndex];
    var topLabel = _labels![topResultIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Classification Result'),
          content: Text(
            'Top label: $topLabel\nProbability: ${topProbability.toStringAsFixed(2)}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

