import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
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
    });
  }

  classifyImage(File image) async {
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
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model/maize_tflite_model.tflite', 
      labels: 'assets/model/maize_labels.txt',
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  captureImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maize Leaf Classification'),
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
                  ? const SizedBox(
                      width: 260,
                      child: Padding(
                        padding: EdgeInsets.all(TSizes.spaceBtwItems),
                        child: Column(
                          children: [
                            Icon(Iconsax.picture_frame),
                            SizedBox(
                              height: 50,
                            )
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
                          const SizedBox(
                            height: 20,
                          ),
                          // ignore: unnecessary_null_comparison
                          _output != null
                            ? Column(
                                children: [
                                  TextButton(
                                    onPressed: () => Get.to(() => DiseaseDetailsScreen(diseaseName: _output[0]['label'])),
                                    child: Text('Result: ${_output[0]['label']}'),
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
                  color: TColors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: captureImage,
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
                  color: TColors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: pickGalleryImage,
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
