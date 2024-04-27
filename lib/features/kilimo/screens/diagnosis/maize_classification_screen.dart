import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../controllers/diseases/disease_details_controller.dart';
import '../../models/disease/disease.dart';
import '../../models/disease/hive_database.dart';
import 'disease_details_screen.dart';

class MaizeDiagnosisScreen extends StatefulWidget {
  const MaizeDiagnosisScreen({super.key});

  @override
  MaizeDiagnosisScreenState createState() => MaizeDiagnosisScreenState();
}

class MaizeDiagnosisScreenState extends State<MaizeDiagnosisScreen> {
  bool _isLoading = true;
  late File _image;
  late List _output;
  late double _accuracy;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    }).catchError((error) {
      debugPrint("Error loading model: $error");
    });
  }
  
  // Classify the image using the loaded TensorFlow Lite model
  Future<void> classifyImage(File image) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 4,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      setState(() {
        _output = output!;
        _isLoading = false;
        _accuracy = _output[0]['confidence'];
      });
    } catch (e) {
      debugPrint("Error classifying image: $e");
    }
  }
  
  // Load the TensorFlow Lite model
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/model/maize_tflite_model.tflite', 
        labels: 'assets/model/maize_labels.txt',
      );
    } catch (e) {
      debugPrint("Failed to load TensorFlow Lite model: $e");
    }
  }

  @override
  void dispose() {
    Tflite.close();
    Hive.close();
    super.dispose();
  }
  
  // Capture image from camera
  Future<void> captureImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });
      classifyImage(_image);
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }
  
  // Pick image from gallery
  Future<void> pickGalleryImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });
      classifyImage(_image);
    } catch (e) {
      debugPrint("Error picking image from gallery: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get disease from controller
    final diseaseController = Get.put(DiseaseDetailsController());

    // Hive service
    HiveService hiveService = HiveService();

    late Disease disease;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maize Disease Detector'),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.notification,
            ),
            onPressed: () {
              // Handle notification icon action
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
            onPressed: () {
              // Show the popup menu when the icon is clicked
              showPopupMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _isLoading
                  ? SizedBox(
                      width: 260,
                      child: Padding(
                        padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                        child: Column(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/icons/crop_image.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: TSizes.spaceBtwSections),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: Image.file(_image),
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          // ignore: unnecessary_null_comparison
                          _output != null
                            ? Column(
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      late double confidence;
                                      confidence = _accuracy;
                                      // Check confidence
                                      if (confidence >= 0.5) {
                                        await Get.to(const DiseaseDetailsScreen())!.then((value) {
                                          disease = Disease(
                                            name: value![0]['label'], 
                                            imagePath: _image.path,
                                          );
                                        });

                                        // Set disease for Disease Controller
                                        diseaseController.setDiseaseValue(disease);

                                        // Save disease
                                        hiveService.addDisease(disease);
                                      } else {
                                        // Display unsure message
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Unable to identify with sufficient confidence.'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Result: ${_output[0]['label']}',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                  ),
                                  Text(
                                    'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%',
                                    style: const TextStyle(
                                      color: TColors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              )
                            : const Center(child: Text("Can't identify", style: TextStyle(fontSize: 30))),
                        ],
                      ),
                    ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(25.5),
                decoration: BoxDecoration(
                  color: TColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    captureImage();
                  },
                  child: const Text(
                    'Take A Photo',
                    style: TextStyle(
                      color: TColors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(25.5),
                decoration: BoxDecoration(
                  color: TColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    pickGalleryImage();
                  },
                  child: const Text(
                    'Pick from Gallery',
                    style: TextStyle(
                      color: TColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
