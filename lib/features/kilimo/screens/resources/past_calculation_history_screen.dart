import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/fertilizer_calculator/fertilizer_controller.dart';

class PastCalculationsScreen extends StatelessWidget {
  PastCalculationsScreen({super.key}); 

  final controller = Get.put(FertilizerController());

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    // Fetch calculation history when the screen is initialized
    controller.fetchCalculationHistory();

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
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() {
            // Handle potential loading state or errors
            if (controller.calculationHistory.isEmpty && controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.calculationHistory.isEmpty) {
              return Center(child: Text('Error: ${controller.error.value}'));
            }

            // Display calculations
            return ListView.builder(
              itemCount: controller.calculationHistory.length,
              itemBuilder: (context, index) {
                final calculation = controller.calculationHistory[index];
                return Card( // Add a Card for visual separation
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(
                      'Crop: ${calculation.cropType}', 
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fertilizer Needed: ${calculation.totalFertilizer.toStringAsFixed(2)} kg'),
                        Text('Date: ${DateFormat('yyyy-MM-dd HH:mm').format(calculation.date.toLocal())}'), // Nicer date format
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
