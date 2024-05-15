import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/fertilizer_calculator/fertilizer_calculator_controller.dart';
import 'widgets/fertilization/calculation_card.dart';

class PastCalculationsScreen extends StatelessWidget {
  PastCalculationsScreen({super.key}); 

  final controller = Get.put(FertilizerCalculatorController());

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left, 
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: const Text('Calculation History')
      ),
      body: SafeArea(
        child: Obx(() {
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
      ),
    );
  }
}
