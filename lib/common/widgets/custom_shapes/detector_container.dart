import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/kilimo/screens/detector/camera_view_screen.dart';
import '../../../util/constants/colors.dart';
import '../../../util/constants/sizes.dart';

class DetectorContainer extends StatelessWidget {
  const DetectorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: TColors.buttonSecondary.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage('assets/icons/detection.png'),
                    )
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'crop_disease_detector'.tr,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "detector_title".tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'detector_sub_title'.tr,
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
