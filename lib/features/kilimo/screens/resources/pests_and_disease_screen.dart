import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/diagnosis_container.dart';
import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/sizes.dart';
import 'widgets/pests_and_diseases_list.dart';

class PestsAndDiseasesScreen extends StatelessWidget {
  const PestsAndDiseasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Pests & diseases'),
      ),
      body: SingleChildScrollView(
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
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      selectCrop(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Select crop',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Icon(Iconsax.arrow_down_1),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Disease By Stage', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'All pests and diseases that might appear in\nyour crop at different stages', 
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Seeding Stage', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TPestsAndDiseasesList(),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {}, 
                  child: const Center(
                    child: Text('See More'),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Vegetative Stage', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TPestsAndDiseasesList(),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {}, 
                  child: const Center(
                    child: Text('See More'),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Flowering Stage', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TPestsAndDiseasesList(),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {}, 
                  child: const Center(
                    child: Text('See More'),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Fruiting Stage', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TPestsAndDiseasesList(),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {}, 
                  child: const Center(
                    child: Text('See More'),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Harvesting Stage', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TPestsAndDiseasesList(),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {}, 
                  child: const Center(
                    child: Text('See More'),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const DiagnosisContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
