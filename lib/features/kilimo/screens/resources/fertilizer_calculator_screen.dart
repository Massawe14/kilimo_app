import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/fertilizer_calculator/fertilizer_controller.dart';
import 'widgets/fertilization/past_calculation_history_screen.dart';

class FertilizerCalculatorScreen extends StatelessWidget {
  FertilizerCalculatorScreen({super.key});

  // Instantiate Controller
  final controller = Get.put(FertilizerController());

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
        title: Text('fertilizer_calculator'.tr),
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
                      'see_relevant_information_on'.tr, 
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
                              controller.selectedCrop.value.isEmpty
                                ? 'select_crop'.tr
                                : controller.selectedCrop.value,
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
                TSectionHeading(title: 'nutrient_quantities'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 73,
                      height: 60,
                      child: TextField(
                        controller: controller.nitrogenController,
                        decoration: InputDecoration(
                          labelText: 'nitrogen'.tr,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 73,
                      height: 60,
                      child: TextField(
                        controller: controller.phosphorusController,
                        decoration: InputDecoration(
                          labelText: 'phosphorus'.tr,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 75,
                      height: 60,
                      child: TextField(
                        controller: controller.potassiumController,
                        decoration: InputDecoration(
                          labelText: 'potassium'.tr,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: 'plot_size'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'fertilizer_subtitle'.tr, 
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TextField(
                  controller: controller.plotSizeController,
                  decoration: InputDecoration(
                    labelText: 'plot_size_label'.tr,
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: controller.calculateFertilizer, // Call the calculate method  
                    child: Text('calculate'.tr),
                  ),
                ),
                // Output display area
                const SizedBox(height: TSizes.spaceBtwSections),
                Obx(() => Text(
                  'Fertilizer Needed: ${controller.fertilizerNeeded.value.toStringAsFixed(2)} kg',
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const CalculationsHistoryScreen()),
                    child: Text('view_history'.tr),
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
