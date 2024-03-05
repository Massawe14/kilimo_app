import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  DiagnosisScreenState createState() => DiagnosisScreenState();
}

class DiagnosisScreenState extends State<DiagnosisScreen> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker(); //allows us to pick image from gallery or camera

  @override
  void initState() {
    //initS is the first function that is executed by default when this class is called
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    //dis function disposes and clears our memory
    super.dispose();
    Tflite.close();
  }

  classifyImage(File image) async {
    // this function runs the model on the image
    try {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 7, // the amount of categories our neural network can predict
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        _output = output!;
        _loading = false;
      });
    } catch (e) {
      debugPrint("Error running TensorFlow Lite model: $e");
    }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model/resnet_model_beans.tflite',
      labels: 'assets/model/labels.txt',
    );
  }

  getImage() async {
    //this function to grab the image from camera
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
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
        title: const Center(child: Text('Diagnosis')),
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
          color: TColors.grey.withOpacity(0.9),
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: TColors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: _loading == true
                    ? null // show nothing if no picture selected
                    : Column(
                      children: [
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 25,
                          thickness: 1,
                        ),
                        // ignore: unnecessary_null_comparison
                        _output != null
                          ? Text(
                              'The disease is: ${_output[0]['label']}!',
                              style: const TextStyle(
                                color: TColors.white,
                                fontSize: TSizes.fontSizeLg,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Container(),
                        const Divider(
                          height: 25,
                          thickness: 1,
                        ),
                      ],
                    ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: getImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 200,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                          color: TColors.darkerGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Take A Photo',
                          style: TextStyle(color: TColors.white, fontSize: TSizes.fontSizeMd),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: pickGalleryImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 200,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                          color: TColors.darkerGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Pick From Gallery',
                          style: TextStyle(color: TColors.white, fontSize: TSizes.fontSizeMd),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

