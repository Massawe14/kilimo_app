import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../../../util/validators/validation.dart';
import '../../controllers/feedback_controller.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(FeedBackController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left, 
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: Text('feedback'.tr),
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
                  'feedback_heading'.tr,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                // Text field and Button
                Form(
                  key: controller.feedbackFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.feedback,
                        validator: (value) => TValidator.validateEmptyText('FeedBack', value),
                        expands: false,
                        decoration: InputDecoration(
                          labelText: 'feedback'.tr,
                          hintText: 'Write your feedback...',
                          prefixIcon: const Icon(Iconsax.message_question),
                        ),
                      ),
                    ],
                  ),
                ),
                // Save Button
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.sendFeedback(),
                    child: Text('send'.tr),
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
