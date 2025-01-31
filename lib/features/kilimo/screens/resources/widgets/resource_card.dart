import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../../util/helpers/helper_functions.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard({
    super.key, 
    required this.icon, 
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: darkMode ? TColors.accent : TColors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            // Use Expanded or Flexible to prevent overflow
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible( // Prevent text overflow
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const Icon(Iconsax.arrow_right_3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
