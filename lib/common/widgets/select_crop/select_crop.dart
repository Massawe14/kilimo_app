import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/kilimo/controllers/fertilizer_calculator/fertilizer_calculator_controller.dart';
import '../../../util/constants/colors.dart';
import '../../../util/constants/image_strings.dart';
import '../../../util/constants/sizes.dart';
import '../../../util/helpers/helper_functions.dart';
import '../custom_shapes/search_container.dart';
import '../image_text_widget/vertical_image_text.dart';
import '../texts/section_heading.dart';

selectCrop(BuildContext context) {
  // Instantiate Controller
  final controller = Get.put(FertilizerCalculatorController());
  final darkMode = THelperFunctions.isDarkMode(context);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select your crop', style: Theme.of(context).textTheme.titleMedium),
        content: Container(
          color: darkMode ? TColors.dark : TColors.white,
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  const TSearchContainer(text: 'Search'),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: TSizes.spaceBtwSections),
                        const TSectionHeading(title: 'Your crops', showActionButton: false),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TVerticalImageText(
                              image: TImages.beanCategory,
                              title: 'Beans',
                              onTap: () {
                                controller.selectedCrop.value = 'Beans';
                                Navigator.of(context).pop('Beans');
                              },
                            ),
                            TVerticalImageText(
                              image: TImages.maizeCategory,
                              title: 'Maize',
                              onTap: () {
                                controller.selectedCrop.value = 'Maize';
                                Navigator.of(context).pop('Maize');
                              },
                            ),
                            TVerticalImageText(
                              image: TImages.cassavaCategory,
                              title: 'Cassava',
                              onTap: () {
                                controller.selectedCrop.value = 'Cassava';
                                Navigator.of(context).pop('Cassava');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                            TVerticalImageText(
                              image: TImages.riceCategory,
                              title: 'Rice',
                              onTap: () {
                                controller.selectedCrop.value = 'Rice';
                                Navigator.of(context).pop('Rice');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel', 
              style: TextStyle(
                color: TColors.info,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}
