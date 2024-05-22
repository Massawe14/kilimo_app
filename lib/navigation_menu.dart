import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimo_app/util/constants/colors.dart';
import 'package:kilimo_app/util/helpers/helper_functions.dart';

import 'features/kilimo/screens/community/community_screen.dart';
import 'features/kilimo/screens/diagnosis/survey_screen.dart';
import 'features/kilimo/screens/home/home_screen.dart';
import 'features/kilimo/screens/resources/resources_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

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
          indicatorColor: darkMode ? TColors.white.withOpacity(0.1) : TColors.buttonSecondary,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home),  label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.layer),  label: 'Surveys'),
            NavigationDestination(icon: Icon(Iconsax.messages),  label: 'Community'),
            NavigationDestination(icon: Icon(Iconsax.more_2),  label: 'Resources'),
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
    const SurveyScreen(),
    CommunityScreen(),
    const ResourcesScreen(),
  ];
}
