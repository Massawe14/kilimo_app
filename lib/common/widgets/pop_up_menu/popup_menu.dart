import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/kilimo/screens/resources/widgets/fertilization/past_calculation_history_screen.dart';
import '../../../util/constants/colors.dart';
import '../../../util/helpers/helper_functions.dart';

// Function to show the popup menu
showPopupMenu(BuildContext context) {
  final darkMode = THelperFunctions.isDarkMode(context);
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(50, 50, 0, 0),
    color: darkMode ? TColors.white : TColors.dark,
    items: [
      const PopupMenuItem(
        value: 'help',
        child: Row(
          children: [
            Icon(Icons.help),
            SizedBox(width: 8),
            Text('Help'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'share',
        child: Row(
          children: [
            Icon(Icons.share),
            SizedBox(width: 8),
            Text('Share'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'history',
        child: Row(
          children: [
            Icon(Icons.history),
            SizedBox(width: 8),
            Text('History'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'aboutUs',
        child: Row(
          children: [
            Icon(Iconsax.info_circle),
            SizedBox(width: 8),
            Text('About Us'),
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
