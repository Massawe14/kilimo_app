import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/community/ask_community_controller.dart';

class AskCommunity extends StatelessWidget {
  const AskCommunity({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Instantiate controller
    final controller = Get.put(AskCommunityController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left, 
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: const Text('Ask Community'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Text(
                  'Improve the probabilty of receiving the right answer', 
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Column(
                  children: [
                    // Crop selection
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton(
                        onPressed: () async {
                          // Show crop selection dialog
                          final selectedCrop = await selectCrop(context);
                          if (selectedCrop != null) {
                            controller.setSelectedCrop(selectedCrop);
                          }
                        },
                        child: Text(
                          controller.selectedCrop.value,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Question input field
                    Obx(
                      () => TextField(
                        //expands: false,
                        // Bind to controller
                        controller: controller.problemTitle.value,
                        decoration: const InputDecoration(
                          labelText: 'Your question to the community',
                          hintText: 'Add a question indicating what\'s wrong with your crop',
                          border: InputBorder.none,
                        ),
                        // Set character limit as specified in the UI
                        maxLength: 200, 
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Crop details text field
                    Obx(
                      () => TextField(
                        //expands: false,
                        controller: controller.problemDescription.value,
                        decoration: const InputDecoration(
                          labelText: 'Description of your problem',
                          hintText: 'Describe specialities such as change of leaves, root colour, bugs, tears...',
                          border: InputBorder.none,
                        ),
                        maxLength: 1500, // Set character limit as specified in the UI
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Display selected image if available
                    Obx(() {
                      controller.isImageUploaded.value = true;
                      return Image.file(
                        File(controller.selectedImage.value.toString()),
                        width: double.infinity, 
                        height: 200, 
                        fit: BoxFit.cover
                      );
                    }),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    // Image uploading
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => controller.pickImage(),
                        child: Text(
                          'upload_image'.tr,
                          style: const TextStyle(color: TColors.accent),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Inside the Form widget's Column children
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.submitData(),
                        child: Text('send'.tr),
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