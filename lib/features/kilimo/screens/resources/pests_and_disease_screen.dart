import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/detector_container.dart';
import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import 'widgets/pestsAndDiseases/pests_and_diseases_list.dart';

class PestsAndDiseasesScreen extends StatelessWidget {
  const PestsAndDiseasesScreen({super.key});

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
        title: Text('pest_and_diseases'.tr),
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
                      'see_relavant_information_on'.tr, 
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        selectCrop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            'select_crop'.tr,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const Icon(Iconsax.arrow_down_1, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: 'disease_by_stage'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'disease_subtitle'.tr, 
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: 'seeding_stage'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TPestsAndDiseasesList(),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: Center(
                      child: Text('see_more'.tr),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: 'vegetative_stage'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TPestsAndDiseasesList(),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: Center(
                      child: Text('see_more'.tr),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: 'flowering_stage'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TPestsAndDiseasesList(),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: Center(
                      child: Text('see_more'.tr),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: 'fruiting_stage'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TPestsAndDiseasesList(),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: Center(
                      child: Text('see_more'.tr),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: 'harvesting_stage'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TPestsAndDiseasesList(),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: Center(
                      child: Text('see_more'.tr),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                const DetectorContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
