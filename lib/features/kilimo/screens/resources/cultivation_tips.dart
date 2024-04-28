import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../util/constants/sizes.dart';
import 'widgets/animated_button.dart';
import 'widgets/container_slider.dart';

class CultivationTipsScreen extends StatelessWidget {
  const CultivationTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Cultivation Tips'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Heading
                Text(
                  'See relavant information on', 
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                OutlinedButton(
                  onPressed: () {
                    selectCrop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Select crop',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Icon(Iconsax.arrow_down_1),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            const Row(
              children: [
                Text('Sowing Date 18 April, 24'),
                SizedBox(width: 5),
                Icon(Icons.edit),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedButton(
                  onPressed: () => ContainerSlider.updateShowDefault(false),
                ),
                AnimatedButton(
                  onPressed: () => ContainerSlider.updateShowDefault(true),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            const Expanded(
              child: ContainerSlider(),
            ),
          ],
        ),
      ),
    );
  }
}