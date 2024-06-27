import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_strings.dart';
import '../../../../../util/helpers/helper_functions.dart';
import '../../../../../util/validators/validation.dart';
import '../../../controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
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
        title: Text(
          'change_name'.tr, 
          style: Theme.of(context).textTheme.headlineSmall,
        ),
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
                  'change_name_heading'.tr,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                // Text field and Button
                Form(
                  key: controller.updateUserNameFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.firstName,
                        validator: (value) => TValidator.validateEmptyText('First Name', value),
                        expands: false,
                        decoration: InputDecoration(
                          labelText: TTexts.firstname,
                          prefixIcon: const Icon(Iconsax.user),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.lastName,
                        validator: (value) => TValidator.validateEmptyText('Last Name', value),
                        expands: false,
                        decoration: InputDecoration(
                          labelText: TTexts.lastname,
                          prefixIcon: const Icon(Iconsax.user),
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
                    onPressed: () => controller.updateUserName(),
                    child: Text('save'.tr),
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