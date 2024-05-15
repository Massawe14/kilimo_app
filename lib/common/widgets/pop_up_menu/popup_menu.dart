import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/kilimo/controllers/diseases/disease_details_controller.dart';
import '../history/history.dart';

// Function to show the popup menu
showPopupMenu(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(50, 50, 0, 0),
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
      Size size = MediaQuery.of(context).size;
      // Get disease from controller
      final diseaseService = Get.put(DiseaseDetailsController());
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => History(size, context, diseaseService))
      );
    }
  });
}
