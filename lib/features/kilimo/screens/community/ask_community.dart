import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../controllers/community/ask_community_controller.dart';

class AskCommunity extends StatelessWidget {
  AskCommunity({super.key});

  final AskCommunityController controller = Get.put(AskCommunityController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Ask Community'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Improve the probabilty of receiving the right answer', 
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Form(
                child: Column(
                  children: [
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
                        child: const Text(
                          'Add Crop',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Question input field
                    TextFormField(
                      expands: false,
                      controller: controller.problem,
                      decoration: const InputDecoration(
                        labelText: 'Your question to the community',
                        hintText: 'Add a question indicating what\'s wrong with your crop',
                      ),
                      maxLength: 200, // Set character limit as specified in the UI
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Crop details text field
                    TextFormField(
                      expands: false,
                      controller: controller.problemDescription,
                      decoration: const InputDecoration(
                        labelText: 'Description of your problem',
                        hintText: 'Describe specialities such as change of leaves, root colour, bugs, tears...',
                      ),
                      maxLength: 2500, // Set character limit as specified in the UI
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Display selected image if available
                    Visibility(
                      // ignore: unnecessary_null_comparison
                      visible: controller.selectedImage != null,
                      child: Image.file(
                        controller.selectedImage,
                        width: double.infinity,
                        height: 200, // Adjust the height as needed
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    // Image uploading
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle image uploading
                          controller.pickImage();
                        },
                        child: const Text(
                          'Upload Crop Image',
                          style: TextStyle(color: TColors.accent),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Inside the Form widget's Column children
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle data submission
                          controller.submitData();
                        },
                        child: const Text('Send'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}