import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/sizes.dart';
import 'cultivation_tips_screen.dart';
import 'fertilizer_calculator_screen.dart';
import 'pests_and_disease_alert_screen.dart';
import 'pests_and_disease_screen.dart';
import 'widgets/resource_card.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('resources'.tr),
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
              // Show the popup menu when the icon is clicked
              showPopupMenu(context);
            },
          ),
        ],
      ),
      drawer: const NavigationDrawerMenu(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search resources'.tr,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Grid view for resource cards
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemCount: resourceData.length,
                  itemBuilder: (context, index) {
                    final resource = resourceData[index];
                    return GestureDetector(
                      onTap: resource['onTap'],
                      child: ResourceCard(
                        icon: resource['icon'],
                        title: resource['title'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Centralized resource data
  List<Map<String, dynamic>> get resourceData => [
    {
      'icon': Iconsax.calculator,
      'title': 'resource_1'.tr,
      'description': 'Calculate fertilizer needs'.tr,
      'onTap': () => Get.to(() => FertilizerCalculatorScreen()),
    },
    {
      'icon': Iconsax.health,
      'title': 'resource_2'.tr,
      'description': 'Learn about pests & diseases'.tr,
      'onTap': () => Get.to(() => const PestsAndDiseasesScreen()),
    },
    {
      'icon': Iconsax.document_normal,
      'title': 'resource_3'.tr,
      'description': 'Cultivation tips'.tr,
      'onTap': () => Get.to(() => const CultivationTipsScreen()),
    },
    {
      'icon': Iconsax.danger,
      'title': 'resource_4'.tr,
      'description': 'Get pest & disease alerts'.tr,
      'onTap': () => Get.to(() => const PestsAndDiseaseAlert()),
    },
  ];
}
