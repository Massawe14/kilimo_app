import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key, 
    required this.title, 
    required this.subTitle,  
    required this.stats, 
    this.icon = Iconsax.chart_1, 
    this.color = TColors.success,
    this.comparisonText = "Compared to last week", 
    this.onTap,
  });

  final String title, subTitle, comparisonText;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(TSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          TSectionHeading(title: title, textColor: TColors.textSecondary, showActionButton: false),
          const SizedBox(height: TSizes.spaceBtwSections),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Main Stat Display
              Text(
                stats.toString(), // Show raw count instead of percentage
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              // Right Side Icon & Comparison
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: color, size: TSizes.iconSm),
                      const SizedBox(width: 4),
                      Text(
                        "$stats", // Show just the number, not a percentage
                        style: Theme.of(context).textTheme.titleLarge!.apply(color: color, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 135,
                    child: Text(
                      comparisonText, // Dynamic comparison text
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
