import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_strings.dart';
import '../../../../../util/helpers/helper_functions.dart';
import '../../../../../util/validators/validation.dart';
import '../../../controllers/update_phonenumber_controller.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // Custom Appbar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left, 
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: Text('Change Phone Number', style: Theme.of(context).textTheme.headlineSmall),
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
                  'Use real phone number for easy verification. This phone number will appear on several pages.',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                // Text field and Button
                Form(
                  key: controller.updateUserPhoneNumberFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.phoneNumber,
                        validator: (value) => TValidator.validatePhoneNumber( value),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: TTexts.phoneNo,
                          prefixIcon: Icon(Iconsax.call),
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
                    onPressed: () => controller.updateUserPhoneNumber(),
                    child: const Text('Save'),
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
