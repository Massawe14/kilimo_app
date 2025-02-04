import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/disease_controller.dart';
import 'agrovet_list_screen.dart';

class DiseaseDetailsScreen extends StatelessWidget {
  const DiseaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final DiseaseController controller = Get.put(DiseaseController());

    // Get disease name from arguments
    final String diseaseName = Get.arguments['diseaseName'] ?? '';

    debugPrint("Disease name: $diseaseName");

    // Fetch disease details when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getDiseaseDetails(diseaseName);
    });

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('disease_details'.tr, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: darkMode ? TColors.white : TColors.black,
                  ),
                )
              : controller.disease.value.id.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TRoundedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.disease.value.name,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'symptoms'.tr, 
                            style: const TextStyle(fontWeight: FontWeight.bold)
                          ),
                          ...controller.disease.value.symptoms.map((symptom) => Text(symptom)),
                          const SizedBox(height: 16.0),
                          Text(
                            'treatments'.tr, 
                            style: const TextStyle(fontWeight: FontWeight.bold)
                          ),
                          ...controller.disease.value.treatment.map((treatment) => Text(treatment)),
                          const SizedBox(height: 16.0),
                          Text(
                            'preventive_measures'.tr, 
                            style: const TextStyle(fontWeight: FontWeight.bold)
                          ),
                          ...controller.disease.value.preventiveMeasures.map((preventive) => Text(preventive)),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Get.to(const AgrovetListScreen()),
                              child: Text('Contact Agrovets'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text('No disease data found'),
                  ),
          ),
        ),
      ),
    );
  }
}
