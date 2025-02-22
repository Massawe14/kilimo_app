import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_strings.dart';
import '../../../../../util/validators/validation.dart';
import '../../../controllers/officer/recommendation_controller.dart';

class TRecommendationForm extends StatelessWidget {
  const TRecommendationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecommendationController());

    return Form(
      key: controller.recommendationFormKey,
      child: Column(
        children: [
          // Disease Name
          TextFormField(
            controller: controller.diseaseName,
            validator: (value) => TValidator.validateEmptyText('Disease Name', value),
            expands: false,
            decoration: InputDecoration(
              hintText: 'disease_name'.tr,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Upload Disease Image
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
          const SizedBox(height: TSizes.spaceBtwSections),
          // Display Selected Image
          Obx(() => controller.imageFile.value != null
            ? Image.file(
                controller.imageFile.value!,
                width: double.infinity, 
                height: 200, 
                fit: BoxFit.cover
              )
            : const SizedBox.shrink(),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Diseases Symptoms (Lists)
          TextFormField(
            controller: controller.symptoms,
            validator: (value) => TValidator.validateEmptyText('Disease Symptoms', value),
            expands: false,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'disease_symptoms'.tr,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Treatment
          TextFormField(
            controller: controller.treatments,
            validator: (value) => TValidator.validateEmptyText('Treatment', value),
            expands: false,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'enter_treatment'.tr,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Preventive Measures
          TextFormField(
            controller: controller.preventiveMeasures,
            validator: (value) => TValidator.validateEmptyText('Preventive Measures', value),
            expands: false,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'enter_preventive_measures'.tr,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.saveRecommendation(),
              child: Text(TTexts.tSave),
            ),
          ),
        ],
      ),
    );
  }
}
