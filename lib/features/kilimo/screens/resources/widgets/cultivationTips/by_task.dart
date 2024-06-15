import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../util/constants/colors.dart';
import '../../../../../../util/constants/sizes.dart';
import 'cultivation_tips_menu_tile.dart';
import 'planting_selection.dart';

class ByTask extends StatelessWidget {
  const ByTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Plant Selection',
                      trailing: Iconsax.arrow_right_3,
                      onTap: () => Get.to(const PlantingSelection()),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Planting',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Plant Training',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Monitoring',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Site Selection',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Field Preparation',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Weeding',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Integration',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Fertilizer Chemical',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Preventive Measure',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Harvesting',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'Post Harvest',
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
