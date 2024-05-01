import 'package:flutter/material.dart';

import '../../../../../../util/constants/colors.dart';
import '../../../../../../util/constants/sizes.dart';
import '../../../../controllers/fertilizer_calculator/fertilizer_calculator_controller.dart';

class FertilizerRecommendation extends StatelessWidget {
  const FertilizerRecommendation({
    super.key, 
    required this.controller,
  });

  final FertilizerCalculatorController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose your preferred fertilizer\ncombination (recommendation amount\nfor one season):', 
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MOP/SSP/Urea', 
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'MOP',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${controller.mop.value} kg',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${controller.mopBagsNeeded.value}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'SSP',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${controller.ssp.value} kg',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${controller.sspBagsNeeded.value}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Urea',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${controller.urea.value} kg',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${controller.ureaBagsNeeded.value}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View Details', 
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
      ],
    );
  }
}
