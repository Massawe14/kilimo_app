import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/fertilizer_calculator/fertilizer_calculator_controller.dart';
import 'widgets/fertilization/calculation_card.dart';

class PastCalculationsScreen extends StatelessWidget {
  PastCalculationsScreen({super.key}); 

  final controller = Get.find<FertilizerCalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Calculation History')
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.pastCalculations.length,
            itemBuilder: (context, index) {
              final calculation = controller.pastCalculations[index];
              return CalculationCard(calculation: calculation); // Your custom CalculationCard
            },
          );
        }
      }),
    );
  }
}
