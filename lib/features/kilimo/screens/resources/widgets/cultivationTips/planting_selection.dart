import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../util/constants/colors.dart';
import '../../../../../../util/constants/sizes.dart';
import '../../../../../../util/helpers/helper_functions.dart';
import '../../../../../personalization/screens/settings/widgets/section_heading.dart';

class PlantingSelection extends StatelessWidget {
  const PlantingSelection({super.key});

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
          title: Text('cultivation_tips'.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.spaceBtwItems),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(title: '2 weeks before seeding', showActionButton: false),
                Text(
                  '4 - 11 Apr',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
