import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../util/constants/colors.dart';
import '../../../../../../util/constants/sizes.dart';
import 'cultivation_tips_menu_tile.dart';

class ByTask extends StatelessWidget {
  const ByTask({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Plant Selection',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Planting',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Plant Training',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Monitoring',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Site Selection',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Field Preparation',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Weeding',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Integration',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Fertilizer Chemical',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Preventive Measure',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Harvesting',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Post Harvest',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
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
