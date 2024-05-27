import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/fertilizer_calculator/fertilizer_controller.dart';

class CalculationsHistoryScreen extends StatelessWidget {
  const CalculationsHistoryScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(FertilizerController());

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
        child: Obx(() {
          // Handle potential loading state or errors
          if (controller.calculationHistory.isEmpty && controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else {
            // Display calculations
            return ListView.builder(
              itemCount: controller.calculationHistory.length,
              itemBuilder: (context, index) {
                final calculation = controller.calculationHistory[index];
                return Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0, // Set elevation to 0 to remove default card shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: darkMode ? TColors.dark : TColors.white,
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            calculation.cropType, 
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 5),
                          const Divider(color: TColors.grey),
                          Text(
                            'Nitrogen: ${calculation.nitrogen}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Phosphorus: ${calculation.phosphorus}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Potassium: ${calculation.potassium}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Plot Size: ${calculation.plotSize} ha',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Fertilizer Needed: ${calculation.totalFertilizer.toStringAsFixed(2)} kg',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Date: ${DateFormat('yyyy-MM-dd HH:mm').format(calculation.date.toLocal())}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ), // Nicer date format
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
