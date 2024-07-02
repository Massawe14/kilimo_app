import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../../personalization/screens/settings/widgets/section_heading.dart';
import 'widgets/pestsAndDiseaseAlert/pests_and_disease_alert_details_screen.dart';

class PestsAndDiseaseAlert extends StatelessWidget {
  const PestsAndDiseaseAlert({super.key});

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
        title: Text('pest_and_disease_alert'.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'pest_and_disease_alert_subtitle'.tr,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/crops_tips.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const Divider(color: TColors.grey),
                const SizedBox(height: TSizes.spaceBtwSections),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 25,
                      height: 25,
                      child: Image(
                        image: AssetImage('assets/icons/tips.png'),
                      )
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'prevention_tips'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: 'field_monitoring'.tr, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  'field_monitoring_subtitle'.tr,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/crop_monitoring.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(const PestsAndDiseaseAlertDetailsScreen()), 
                    child: Center(
                      child: Text('learn_more'.tr),
                    ),
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
