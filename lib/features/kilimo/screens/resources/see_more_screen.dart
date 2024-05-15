import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/diagnosis_container.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../../personalization/screens/settings/widgets/section_heading.dart';
import 'widgets/pestsAndDiseases/pests_and_diseases_menu_tile.dart';

class SeeMoreScreen extends StatelessWidget {
  const SeeMoreScreen({
    super.key, 
    required this.heading,
    required this.image, 
    required this.title, 
    required this.subTitle,
  });

  final String heading, image, title, subTitle;

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
        title: const Text('See More'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                TSectionHeading(title: heading, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Pests and diseases that might appear in\nyour crops, ordered from common to\nleast common', 
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return TPestsAndDiseasesMenuTile(
                      image: image,
                      title: title,
                      subTitle: subTitle,
                      icon: Iconsax.arrow_right_3,
                    );
                  }
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                const DiagnosisContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}