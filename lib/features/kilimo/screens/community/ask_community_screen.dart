import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/community/post_community_controller.dart';

class AskCommunity extends StatelessWidget {
  const AskCommunity({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Instantiate controller
    final controller = Get.put(PostCommunityController());
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
        title: Text('ask_community'.tr),
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
                  'ask_community_heading'.tr, 
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Column(
                  children: [
                    // Crop Selection
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton(
                        onPressed: () async {
                          // Crop Selection
                          final selectedCrop = await selectCrop(context);
                          if (selectedCrop != null) {
                            controller.selectedCrop.value = selectedCrop;
                          }
                        },
                        child: Obx(
                          () => Text(
                            controller.selectedCrop.value.isEmpty
                              ? 'select_crop'.tr
                              : controller.selectedCrop.value, // Display selected crop
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Question Title
                    TextField(
                      controller: controller.problemTitleController,
                      decoration: InputDecoration(
                        hintText: 'add_question'.tr,
                        border: InputBorder.none,
                      ),
                      // Set character limit as specified in the UI
                      maxLength: 200, 
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Problem Description
                    TextField(
                      controller: controller.problemDescriptionController,
                      decoration: InputDecoration(
                        hintText: 'describe_question'.tr,
                        border: InputBorder.none,
                      ),
                      maxLines: null, // Allow unlimited lines
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Location
                    TextField(
                      controller: controller.locationController,
                      decoration: InputDecoration(
                        hintText: 'your_location'.tr,
                        border: InputBorder.none,
                      ),
                      enabled: false, // Disable user input
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Display Selected Image
                    Obx(() =>controller.imageFile.value != null
                      ? Image.file(
                          controller.imageFile.value!,
                          width: double.infinity, 
                          height: 200, 
                          fit: BoxFit.cover
                        )
                      : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    // Image Upload Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => controller.pickImage(),
                        child: Obx(
                          () => Text(
                            controller.imageFile.value == null 
                            ? 'upload_image'.tr : 'change_image'.tr,
                            style: const TextStyle(color: TColors.accent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    //Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: () => controller.submitPost(), // Trigger action
                          child: controller.isLoading.value // Use value directly
                            ? const CircularProgressIndicator(color: TColors.white) // Loading indicator
                            : Text('send'.tr)
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
