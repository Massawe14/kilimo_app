import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/maize/maize_controller.dart';
import 'disease_details_screen.dart';

class MaizeDetectorScreen extends StatelessWidget {
  const MaizeDetectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MaizeDetectorController());
    final darkMode = THelperFunctions.isDarkMode(context);

    Future<void> captureImage(ImageSource source) async {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        File image = File(pickedImage.path);
        // Call the classifyImage function from the controller with the picked image
        controller.classifyImage(image);
        // Update the image in the controller
        controller.image.value = image; 
      } else {
        // Handle case where the user canceled image selection
        debugPrint('No image selected');
      }
    }

    // Clear output when the screen is closed
    void clearOutputOnClose() {
      controller.isLoading.value = true;
      controller.output.clear();
      controller.image.value = null; 
      controller.accuracy.value = 0.0;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            clearOutputOnClose(); 
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_left, 
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: Text('maize_disease_detector'.tr),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Center(
                    child: controller.isLoading.value 
                      ? (controller.image.value != null
                        ? CircularProgressIndicator(
                            color: darkMode ? TColors.white : TColors.black,
                          )
                        : SizedBox(
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
                                ],
                              ),
                            ),
                          )
                        )
                      : SizedBox(
                          width: double.infinity, // Make the container take the full width
                          child: Column(
                            children: [
                              if (controller.image.value != null)
                                Image.file(controller.image.value!),
                              const SizedBox(height: TSizes.spaceBtwSections),
                              if (controller.output.isNotEmpty)
                                Column(
                                  children: [
                                    Text(
                                      'result: ${controller.output[0]['label']}'.tr,
                                      style: const TextStyle(
                                        color: TColors.black, 
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center, // Center the text
                                    ),
                                    Text(
                                      'accuracy: ${(controller.accuracy.value * 100).toStringAsFixed(2)}%'.tr,
                                      style: const TextStyle(
                                        color: TColors.black, 
                                        fontSize: 20
                                      ),
                                      textAlign: TextAlign.center, // Center the text
                                    ),
                                    const SizedBox(height: TSizes.spaceBtwSections),
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
                                          Get.to(() => const DiseaseDetailsScreen(), arguments: {
                                            'diseaseName': controller.output[0]['label'],
                                          });
                                        },
                                        child: Text(
                                          'recommendations'.tr,
                                          style: const TextStyle(
                                            color: TColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              else if (!controller.isLoading.value) // Show 'can't identify' only after loading is done
                                Center(
                                  child: Text(
                                    "can't_identify".tr, 
                                    style: const TextStyle(fontSize: 30),
                                  )
                                ),
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
                    color: TColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () {
                      captureImage(ImageSource.camera);
                    },
                    child: Text(
                      'take_a_photo'.tr,
                      style: const TextStyle(
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
                      captureImage(ImageSource.gallery);
                    },
                    child: Text(
                      'pick_from_gallery'.tr,
                      style: const TextStyle(
                        color: TColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
