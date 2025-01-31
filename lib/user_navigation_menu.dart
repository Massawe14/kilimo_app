import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/kilimo/screens/community/community_screen.dart';
import 'features/kilimo/screens/detector/real_time_detection_screen.dart';
import 'features/kilimo/screens/home/home_screen.dart';
import 'features/kilimo/screens/resources/resources_screen.dart';
import 'util/constants/colors.dart';
import 'util/helpers/helper_functions.dart'; 

class UserNavigationMenu extends StatelessWidget {
  const UserNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode ? TColors.white.withAlpha(26) : TColors.buttonSecondary,
          destinations: [
            NavigationDestination(
              icon: const Icon(Iconsax.home),  
              label: 'home'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Iconsax.layer),  
              label: 'detector'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Iconsax.messages),  
              label: 'community'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Iconsax.more_2),  
              label: 'resources'.tr,
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const RealTimeDetectionScreen(),
    CommunityScreen(),
    const ResourcesScreen(),
  ];
}
