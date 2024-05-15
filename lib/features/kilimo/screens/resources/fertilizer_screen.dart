import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/fertilizer_calculator/fertilizer_controller.dart';

class FertilizerScreen extends StatelessWidget {
  FertilizerScreen({super.key});

  final FertilizerController controller = Get.put(FertilizerController());
  
  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
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
                      // Crop Dropdown (using GetX binding)
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: controller.selectedCrop.value,
                          items: controller.cropNutrientRequirements.keys.map(
                            (crop) => DropdownMenuItem(
                              value: crop,
                              child: Text(crop),
                            )
                          ).toList(), 
                          onChanged: (value) => controller.selectedCrop.value = value!,
                          decoration: const InputDecoration(
                            labelText: 'Crop',
                          ),
                          validator: (value) => value == null ? "Please select a crop" : null,
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
                              controller.nController.value.toString(), 
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
                              controller.pController.value.toString(), 
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
                              controller.kController.value.toString(), 
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
                      // Call the controller's method
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Pass values to controller
                          controller.calculateAndSave();
                        }
                      },
                      child: const Text('Calculate'),
                    ),
                  ),
                  // Display results (using GetX binding)
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Obx(
                    () => controller.results.isEmpty
                      ? Container()
                      : Column(
                        children: controller.results.entries.map(
                          (entry) => Text('${entry.key}: ${entry.value}')
                        ).toList(),
                      ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
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
                    controller.resetNutrients;
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
                    controller.saveTemporaryNutrients;
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
      controller.selectedUnit.value = value;
    } else {
      controller.selectedUnit.value = value;
    }
  }
}