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
                              ? 'Select Crop'
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
                      decoration: const InputDecoration(
                        labelText: 'Your question to the community',
                        hintText: 'Add a question...',
                      ),
                      // Set character limit as specified in the UI
                      maxLength: 200, 
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Problem Description
                    TextField(
                      controller: controller.problemDescriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description of your problem',
                        hintText: 'Describe specialities...',
                      ),
                      maxLines: null, // Allow unlimited lines
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
                            ? 'upload_image'.tr : 'Change Image',
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
