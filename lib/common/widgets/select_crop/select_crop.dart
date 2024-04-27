import 'package:flutter/material.dart';

import '../../../util/constants/colors.dart';
import '../../../util/constants/image_strings.dart';
import '../../../util/constants/sizes.dart';
import '../custom_shapes/search_container.dart';
import '../image_text_widget/vertical_image_text.dart';
import '../texts/section_heading.dart';

Future<dynamic> selectCrop(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select your crop', style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: TColors.white,
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              const TSearchContainer(text: 'Search'),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceBtwSections),
                    const TSectionHeading(title: 'Your crops', showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TVerticalImageText(
                              image: TImages.beanCategory,
                              title: 'Beans',
                              onTap: () {
                                Navigator.of(context).pop('Beans');
                              },
                            ),
                            TVerticalImageText(
                              image: TImages.maizeCategory,
                              title: 'Maize',
                              onTap: () {
                                Navigator.of(context).pop('Maize');
                              },
                            ),
                            TVerticalImageText(
                              image: TImages.cassavaCategory,
                              title: 'Cassava',
                              onTap: () {
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
                                Navigator.of(context).pop('Rice');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
              ),
            ],
          ),
        ),
      );
    },
  );
}
