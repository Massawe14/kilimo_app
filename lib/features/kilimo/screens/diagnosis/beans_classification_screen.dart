import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../controllers/beans/beans_controller.dart';

class BeansDiagnosisScreen extends StatelessWidget {
  const BeansDiagnosisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BeansDiagnosisController());

    captureImage() async {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        File image = File(pickedImage.path);
        // Call the classifyImage function from the controller with the picked image
        controller.classifyImage(image);
      } else {
        // Handle case where the user canceled image selection
        debugPrint('No image selected');
      }
    }

    pickGalleryImage() async {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        File image = File(pickedImage.path);
        // Call the classifyImage function from the controller with the picked image
        controller.classifyImage(image);
      } else {
        // Handle case where the user canceled image selection
        debugPrint('No image selected');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beans Leaf Classification'),
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
              Obx(
                () => Center(
                  child: controller.isLoading.value
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
                              child: Image.file(controller.image.value!),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            controller.output.isNotEmpty
                              ? Column(
                                  children: [
                                    Text(
                                      'Result: ${controller.output[0]['label']}',
                                      style: const TextStyle(
                                        color: TColors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'Accuracy: ${(controller.accuracy.value * 100).toStringAsFixed(2)}%',
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
                  color: TColors.green,
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
