import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/fertilizer_calculator/fertilizer_controller.dart';
import 'past_calculation_history_screen.dart';

class FertilizerCalculatorScreen extends StatelessWidget {
  FertilizerCalculatorScreen({super.key});

  // Instantiate Controller
  final controller = Get.put(FertilizerController());

  final _formKey = GlobalKey<FormState>();

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
                            controller: controller.nController,
                            decoration: const InputDecoration(labelText: 'N'),
                            keyboardType: TextInputType.number,
                        ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 60,
                          child: TextField(
                            controller: controller.pController,
                            decoration: const InputDecoration(labelText: 'P'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 60,
                          child: TextField(
                            controller: controller.kController,
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
                    controller.resetNutrients();
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
                    controller.saveTemporaryNutrients();
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
    controller.selectedUnit.value = value;
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
            child: Form(
              key: _formKey,
              onChanged: () => controller.checkFormValidity(),
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
                                controller.selectedCrop.value,
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
                          child: Text(
                            controller.nController.text, 
                            style: const TextStyle(
                              fontSize: 12,
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
                          child: Text(
                            controller.pController.text, 
                            style: const TextStyle(
                              fontSize: 12,
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
                          child: Text(
                            controller.kController.text, 
                            style: const TextStyle(
                              fontSize: 12,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          () => TextFormField(
                            decoration: InputDecoration(labelText: controller.selectedUnit.value),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => controller.plotSizeController.value,
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
                      onPressed: controller.isFormValid.value 
                      ? controller.calculateAndSave 
                      : null,
                      child: const Text('Calculate'),
                    ),
                  ),
                  // Output display area
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Obx(
                    () => controller.results.isEmpty
                      ? Container()
                      : Column(children: controller.results.entries.map(
                          (entry) => Text(
                            '${entry.key}: ${entry.value}',
                          ),
                        ).toList(),
                      ),
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
      ),
    );
  }
}
