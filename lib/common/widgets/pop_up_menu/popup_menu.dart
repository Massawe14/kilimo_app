import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/kilimo/screens/resources/widgets/fertilization/past_calculation_history_screen.dart';

// Function to show the popup menu
showPopupMenu(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(50, 50, 0, 0),
    items: [
      PopupMenuItem(
        value: 'help',
        child: Row(
          children: [
            const Icon(Icons.help),
            const SizedBox(width: 8),
            Text('help'.tr),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'share',
        child: Row(
          children: [
            const Icon(Icons.share),
            const SizedBox(width: 8),
            Text('share'.tr),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'history',
        child: Row(
          children: [
            const Icon(Icons.history),
            const SizedBox(width: 8),
            Text('history'.tr),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'aboutUs',
        child: Row(
          children: [
            const Icon(Iconsax.info_circle),
            const SizedBox(width: 8),
            Text('about_us'.tr),
          ],
        ),
      ),
    ],
  ).then((value) {
    // Handle the selected item
    if (value == 'help') {
      // Handle help action
    } else if (value == 'share') {
      // Handle share action
    } else if (value == 'history') {
      Get.to(() => const CalculationsHistoryScreen());
    }
  });
}
