import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image/image.dart' as img;
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
    //initState is the first function that is executed by default when this class is called
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    //This function disposes and clears our memory
    super.dispose();
    Tflite.close();
  }

  captureImage() async {
    //this function to grab the image from camera
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImageBinary(_image);
  }

  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    
    classifyImageBinary(_image);
  }

  loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/model/resnet_model_beans.tflite',
        labels: 'assets/model/labels.txt',
      );
    } on PlatformException {
      debugPrint('Failed to load model.');
    }
  }

  // classifyImage(File image) async {
  //   // this function runs the model on the image
  //   try {
  //     int startTime = DateTime.now().millisecondsSinceEpoch;
  //     var output = await Tflite.runModelOnImage(
  //       path: image.path,
  //       numResults: 7,
  //       threshold: 0.5,
  //       imageMean: 127.5,
  //       imageStd: 127.5,
  //       asynch: true,
  //     );

  //     setState(() {
  //       _output = output!;
  //       _loading = false;
  //     });

  //     int endTime = DateTime.now().millisecondsSinceEpoch;
  //     debugPrint("Inference took ${endTime - startTime}ms");
  //   } catch (e) {
  //     debugPrint("Error running TensorFlow Lite model: $e");
  //   }
  // }

  Uint8List imageToByteListFloat32(img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);

    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (pixel.r - mean) / std;
        buffer[pixelIndex++] = (pixel.g - mean) / std;
        buffer[pixelIndex++] = (pixel.b - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Future classifyImageBinary(File image) async {
    try {
      int startTime = DateTime.now().millisecondsSinceEpoch;
      var imageBytes = (await rootBundle.load(image.path)).buffer;

      img.Image? oriImage = img.decodeJpg(imageBytes.asUint8List());
      img.Image resizedImage = img.copyResize(oriImage!, height: 512, width: 512);

      var output = await Tflite.runModelOnBinary(
        binary: imageToByteListFloat32(resizedImage, 512, 127.5, 127.5),
        numResults: 7,
        threshold: 0.05,
      );

      setState(() {
        _output = output!;
        _loading = false;
      });

      int endTime = DateTime.now().millisecondsSinceEpoch;
      debugPrint("Inference took ${endTime - startTime}ms");
    } catch (e) {
      debugPrint("Error running TensorFlow Lite model: $e");
    }
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
          // padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
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
                    ? null
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
                      onTap: captureImage,
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

