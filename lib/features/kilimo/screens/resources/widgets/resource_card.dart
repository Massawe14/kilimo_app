import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded( // Wrap the Row with Expanded
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: TColors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(icon), // Custom icon inside circle
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(width: TSizes.defaultSpace), // Add space between icon and arrow
            const Center(child: Icon(Iconsax.arrow_right_3)),
          ],
        ),
      ),
    );
  }
}
