import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
            if (controller.calculationHistory.isEmpty) {
              return const Center(
                child: Center(
                  child: Text('No calculations found.'),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.calculationHistory.length,
                itemBuilder: (context, index) {
                  final calculation = controller.calculationHistory[index];
                  return ListTile(
                    title: Text('Crop: ${calculation.cropType}'),
                    subtitle: Text('Fertilizer Needed: ${calculation.totalFertilizer.toStringAsFixed(2)} kg\n'
                      'Date: ${calculation.date.toLocal()}'),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
