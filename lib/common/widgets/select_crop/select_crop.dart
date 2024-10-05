import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/kilimo/controllers/fertilizer_calculator/fertilizer_controller.dart';
import '../../../util/constants/colors.dart';
import '../../../util/constants/image_strings.dart';
import '../../../util/constants/sizes.dart';
import '../image_text_widget/vertical_image_text.dart';

selectCrop(BuildContext context) {
  // Instantiate Controller
  final controller = Get.put(FertilizerController());
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'crop_title'.tr, 
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TVerticalImageText(
                              image: TImages.beanCategory,
                              title: 'beans'.tr,
                              onTap: () {
                                controller.selectedCrop.value = 'beans'.tr;
                                Navigator.of(context).pop('beans'.tr);
                              },
                            ),
                            TVerticalImageText(
                              image: TImages.maizeCategory,
                              title: 'maize'.tr,
                              onTap: () {
                                controller.selectedCrop.value = 'maize'.tr;
                                Navigator.of(context).pop('maize'.tr);
                              },
                            ),
                            TVerticalImageText(
                              image: TImages.cassavaCategory,
                              title: 'cassava'.tr,
                              onTap: () {
                                controller.selectedCrop.value = 'cassava'.tr;
                                Navigator.of(context).pop('cassava'.tr);
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
                              title: 'rice'.tr,
                              onTap: () {
                                controller.selectedCrop.value = 'rice'.tr;
                                Navigator.of(context).pop('rice'.tr);
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
            child: Text(
              'cancel'.tr, 
              style: const TextStyle(
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
