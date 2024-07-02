import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../util/constants/colors.dart';
import '../../../../../../util/constants/sizes.dart';
import '../../../../../../util/helpers/helper_functions.dart';
import '../../../detector/camera_view_screen.dart';
import 'pests_and_disease_alert_details_appbar.dart';

class PestsAndDiseaseAlertDetailsScreen extends StatelessWidget {
  const PestsAndDiseaseAlertDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const PestsAndDiseaseAlertDetailsAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4.0),
                  Text(
                    'field_monitoring'.tr,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'field_monitoring_description'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    "why_monitoring".tr,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    "monitoring_field_help".tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image(
                          image: const AssetImage('assets/icons/checked.png'),
                          color: darkMode ? TColors.accent : TColors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'help_1'.tr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image(
                          image: const AssetImage('assets/icons/checked.png'),
                          color: darkMode ? TColors.accent : TColors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'help_2'.tr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image(
                            image: const AssetImage('assets/icons/info.png'),
                            color: darkMode ? TColors.accent : TColors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'info'.tr,
                            style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.kSecondaryTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    "how_to_monitor".tr,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image(
                                image: const AssetImage('assets/icons/number-1.png'),
                                color: darkMode ? TColors.accent : TColors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "visit_your_field".tr,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                Text(
                                  "how_1".tr,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image(
                                image: const AssetImage('assets/icons/number-2.png'),
                                color: darkMode ? TColors.accent : TColors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "check_several_spots".tr,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                Text(
                                  "how_2".tr,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image(
                                image: const AssetImage('assets/icons/number-3.png'),
                                color: darkMode ? TColors.accent : TColors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "step_3".tr,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                Text(
                                  "how_3".tr,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image(
                                image: const AssetImage('assets/icons/number-4.png'),
                                color: darkMode ? TColors.accent : TColors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "carefully_examine_the_entire_crop".tr,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                Text(
                                  "how_4".tr,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    "take_action_if_you_spot_something".tr,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    "take_action_subtitle".tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const CameraViewScreen()),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 25,
                              height: 25,
                              child: Image(
                                image: AssetImage('assets/icons/detection.png'),
                                color: TColors.white,
                              )
                            ),
                            const SizedBox(width: 5),
                            Text('start_diagnosis'.tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'addition_description'.tr,
                    style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: TColors.kSecondaryTextColor),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
