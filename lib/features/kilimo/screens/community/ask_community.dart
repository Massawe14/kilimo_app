import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';

class AskCommunity extends StatelessWidget {
  const AskCommunity({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Ask Community'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.attach_circle, color: TColors.green),
            onPressed: () {
              // Handle attach icon action
            },
          ),
          IconButton(
            icon: const Icon(Iconsax.send_1, color: TColors.green),
            onPressed: () {
              // Handle send icon action
            },
          ),
        ],
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
                        onPressed: () {
                          selectCrop(context);
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
                      decoration: const InputDecoration(
                        labelText: 'Description of your problem',
                        hintText: 'Describe specialities such as change of leaves, root colour, bugs, tears...',
                      ),
                      maxLength: 2500, // Set character limit as specified in the UI
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