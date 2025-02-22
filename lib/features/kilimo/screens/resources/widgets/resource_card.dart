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
    return Container(
      width: 350,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128), // 0.5 * 255 = 127.5, rounded to 128
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0, // Set elevation to 0 to remove default card shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: TColors.white,
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
      ),
    );
  }
}
