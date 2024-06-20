import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/disease_controller.dart';

class DiseaseDetailsScreen extends StatelessWidget {
  const DiseaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final DiseaseController controller = Get.put(DiseaseController());
    final String diseaseName = Get.arguments['diseaseName'];

    // Fetch disease details when the screen loads
    controller.getDiseaseDetails(diseaseName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Details')
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: darkMode ? TColors.white : TColors.black,
            )
          );
        }

        if (controller.disease.value.name.isEmpty) {
          return const Center(
            child: Text('No disease details available')
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${controller.disease.value.name}', 
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Symptoms: ${controller.disease.value.symptoms}', 
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Causes: ${controller.disease.value.causes}', 
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Treatment: ${controller.disease.value.treatment}', 
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }),
    );
  }
}
