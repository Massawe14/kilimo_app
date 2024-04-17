import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/search_container.dart';
import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import 'ask_community.dart';
import 'widgets/crop_categories.dart';
import 'widgets/crop_list.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {
              // Handle notification icon action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {
              showPopupMenu(context);
            },
          ),
        ],
      ),
      drawer: const NavigationDrawerMenu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Section
            const TSearchContainer(text: 'Search in Community'),
            const SizedBox(height: TSizes.spaceBtwSections),
            // Filter Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter by',
                    style: TextStyle(
                      color: TColors.dark,
                      fontSize: TSizes.fontSizeMd,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'change',
                      style: TextStyle(
                        color: TColors.green,
                        fontSize: TSizes.fontSizeMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // Crop Categories
            const Padding(
              padding: EdgeInsets.only(left: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Heading
                  TSectionHeading(title: 'Crop Categories', showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),
                  // Categories
                  CropCategories(),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // Crop List
            const TCropList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const AskCommunity()),
        label: const Text('Ask Community', style: TextStyle(color: TColors.white)),
        icon: const Icon(Iconsax.receipt_edit, color: TColors.white),
        backgroundColor: TColors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
