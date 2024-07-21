import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/disease_controller.dart';

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
      appBar: AppBar(
        title: Text('disease_details'.tr)
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.disease.value.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16.0),
                        const Text('Symptoms:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...controller.disease.value.symptoms.map((symptom) => Text(symptom)),
                        const SizedBox(height: 16.0),
                        const Text('Treatments:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...controller.disease.value.treatment.map((treatment) => Text(treatment)),
                        const SizedBox(height: 16.0),
                        const Text('Preventive Measures:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...controller.disease.value.preventiveMeasures.map((preventive) => Text(preventive)),
                      ],
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
