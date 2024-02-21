import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/services/classify_image.dart';
import '../../../common/widgets/loadingModal.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  DiagnosisScreenState createState() => DiagnosisScreenState();
}

class DiagnosisScreenState extends State<DiagnosisScreen> {
  PickedFile? _image;
  String? _result;

  final TFLiteService _tfliteService = TFLiteService();

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  Future<void> _initModel() async {
    _showLoadingModal();
    await _tfliteService.loadModel();
    _hideLoadingModal();
  }

  Future<void> _classifyImage() async {
    _showLoadingModal();

    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _image = PickedFile(pickedImage.path);
        var classificationResult = await _tfliteService.classifyImage(_image!);

        if (classificationResult['success']) {
          setState(() {
            _result = classificationResult['result'];
          });

          Fluttertoast.showToast(
            msg: "Result: $_result",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Error: ${classificationResult['error']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }

    _hideLoadingModal();
  }

  void _showLoadingModal() {
    setState(() {
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const LoadingModal(),
    );
  }

  void _hideLoadingModal() {
    setState(() {
    });

    Navigator.of(context).pop(); // Close the loading modal
  }

  @override
  void dispose() {
    _tfliteService.closeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null 
              ? Container(
                  width: 200.0,
                  height: 150.0,
                  color: Colors.grey,
                  child: IconButton(
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                    onPressed: () async {
                      // Add functionality to upload image from local file
                      final picker = ImagePicker();
                      final pickedImage = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      setState(() {
                        _image = pickedImage as PickedFile?;
                      });
                      _classifyImage();
                    },
                  ),
                )
              : Image.file(
                File(_image!.path),
                height: 150.0,
                width: 200.0,
              ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                // Add functionality for scanning object
              },
              icon: const Icon(Icons.scanner),
              label: const Text('Scan Crop'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                // Add functionality to take a picture of crop with the camera
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Picture'),
            ),
            const SizedBox(height: 20.0),
            // _result != null 
            //   ? Text('Result: $_result')
            //   : Container(),
          ],
        ),
      ),
    );
  }
}

