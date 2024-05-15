import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/search_container.dart';
import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import 'ask_community_screen.dart';
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search Section
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems),
              sliver: SliverToBoxAdapter(
                child: TSearchContainer(text: 'Search in community'),
              ),
            ),
            // Filter Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              sliver: SliverToBoxAdapter(
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
                          color: TColors.accent,
                          fontSize: TSizes.fontSizeMd,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Crop Categories Section
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TSectionHeading(title: 'Crop categories', showActionButton: false),
                    SizedBox(height: TSizes.spaceBtwItems),
                    CropCategories(),
                  ],
                ),
              ),
            ),
            // Crop List Section
            const SliverPadding(
              padding: EdgeInsets.all(5),
              sliver: TCropList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        onPressed: () => Get.to(() => const AskCommunity()),
        backgroundColor: TColors.accent,
        label: const Text('Ask Community', style: TextStyle(color: TColors.white)),
        icon: const Icon(Iconsax.receipt_edit, color: TColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
