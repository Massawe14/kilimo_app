import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/fertilizer_calculator/fertilizer_calculator_controller.dart';
import 'past_calculation_history_screen.dart';
import 'widgets/fertilization/fertizer_recommendation.dart';

class FertilizerCalculatorScreen extends StatefulWidget {
  const FertilizerCalculatorScreen({super.key});

  @override
  FertilizerCalculatorScreenState createState() => FertilizerCalculatorScreenState();
}

class FertilizerCalculatorScreenState extends State<FertilizerCalculatorScreen> {
  // Instantiate Controller
  final controller = Get.put(FertilizerCalculatorController());

  showNutrientQuantitiesDialog(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nutrient quantities', style: Theme.of(context).textTheme.titleMedium),
          content: Container(
            width: double.maxFinite,
            color: darkMode ? TColors.dark : TColors.white,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 60,
                          child: TextField(
                            controller: controller.nitrogenController,
                            decoration: const InputDecoration(labelText: 'N'),
                            keyboardType: TextInputType.number,
                        ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 60,
                          child: TextField(
                            controller: controller.phosphorusController,
                            decoration: const InputDecoration(labelText: 'P'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 60,
                          child: TextField(
                            controller: controller.potassiumController,
                            decoration: const InputDecoration(labelText: 'K'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    controller.resetNutrientQuantities();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Reset', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add save logic here
                    controller.saveNutrientQuantities();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Save', 
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _selectUnit(value) {
    if (controller.selectedUnit.value != 'Acre') {
      setState(() {
        controller.selectedUnit.value = value;
      });
    } else {
      setState(() {
        controller.selectedUnit.value = value;
      });
    }
  }

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
        title: const Text('Fertilizer Calculator'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Heading
                    Text(
                      'See relavant information on', 
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        selectCrop(context);
                      },
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              controller.selectedCrop.value.isNotEmpty 
                              ? controller.selectedCrop.value
                              : 'Select crop',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          const Icon(Iconsax.arrow_down_1, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TSectionHeading(title: 'Nutrient quantities', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 73,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {
                          showNutrientQuantitiesDialog(context);
                        },
                        child: Obx(
                          () => Text(
                            controller.nitrogen.value, 
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 73,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {
                          showNutrientQuantitiesDialog(context);
                        },
                        child: Obx(
                          () => Text(
                            controller.phosphorus.value, 
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 75,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {
                          showNutrientQuantitiesDialog(context);
                        },
                        child: Obx(
                          () => Text(
                            controller.potassium  .value, 
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    TextButton(
                      onPressed: () {
                        showNutrientQuantitiesDialog(context);
                      },
                      child: const Text(
                        'Edit', 
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TSectionHeading(title: 'Unit', showActionButton: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: "Acre",
                      groupValue: controller.selectedUnit.value,
                      onChanged: (value) => _selectUnit(value),
                    ),
                    const Text('Acre'),
                    Radio(
                      value: "Hector",
                      groupValue: controller.selectedUnit.value,
                      onChanged: (value) => _selectUnit(value),
                    ),
                    const Text('Hector'),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TSectionHeading(title: 'Plot size', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sizes smaller than one unit are expressed as 0.\nExample: half acre = 0.5', 
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Iconsax.minus),
                      onPressed: controller.decrementPlotSize,
                    ),
                    Expanded(
                      child: Obx(
                        () => TextField(
                          decoration: InputDecoration(labelText: controller.selectedUnit.value),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              controller.plotSize.value = double.parse(value);
                              controller.isCalculateButtonEnabled.value = true;
                            } else {
                              controller.isCalculateButtonEnabled.value = false;
                            }
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.add),
                      onPressed: controller.incrementPlotSize,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: controller.isCalculateButtonEnabled.value 
                    ? controller.calculateFertilizer 
                    : null,
                    child: const Text('Calculate'),
                  ),
                ),
                // Output display area
                const SizedBox(height: TSizes.spaceBtwSections),
                Obx(
                  () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.isCalculationDone.value
                        ? FertilizerRecommendation(controller: controller)
                        : const SizedBox(),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => PastCalculationsScreen()),
                    child: const Text('View History'),
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
