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
                      title: 'plant_selection'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: () => Get.to(const PlantingSelection()),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'planting'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'plant_training'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'monitoring'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'site_selection'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'field_preparation'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'weeding'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'integration'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'fertilizer_chemical'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'preventive_measure'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'harvesting'.tr,
                      trailing: Iconsax.arrow_right_3,
                      onTap: (){},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      leading: Iconsax.security_user,
                      title: 'post_harvest'.tr,
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
