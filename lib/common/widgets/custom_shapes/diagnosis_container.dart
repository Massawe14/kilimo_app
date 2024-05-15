import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/kilimo/screens/diagnosis/survey_screen.dart';
import '../../../util/constants/colors.dart';
import '../../../util/constants/sizes.dart';

class DiagnosisContainer extends StatelessWidget {
  const DiagnosisContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: TColors.buttonSecondary.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  'Crop diagnosis',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Identify your crop's issues in a\nfew seconds",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  'Quickly identify the exact problem\nwith your crop.',
                  style: Theme.of(context).textTheme.bodySmall
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const SurveyScreen()),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Image(
                          image: AssetImage('assets/icons/detection.png'),
                          color: TColors.white,
                        )
                      ),
                      SizedBox(width: 5),
                      Text('Diagnose'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
