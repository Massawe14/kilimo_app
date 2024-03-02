import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/colors.dart';

// Function to build the drawer
Drawer openDrawer(BuildContext context) {
  return Drawer(
    // Drawer content
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // Drawer header with user information
        const DrawerHeader(
          decoration: BoxDecoration(
            color: TColors.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add your user profile image or icon here
              CircleAvatar(
                radius: 30,
                backgroundColor: TColors.white,
                // Add user profile image or icon
                // backgroundImage: NetworkImage('url_to_user_image'),
              ),
              SizedBox(height: 10),
              // Add user name and email
              Text(
                'User Name',
                style: TextStyle(color: TColors.white, fontSize: 18),
              ),
              Text(
                'user@email.com',
                style: TextStyle(color: TColors.white),
              ),
            ],
          ),
        ),
        // Drawer items
        ListTile(
          leading: const Icon(Iconsax.user),
          title: const Text('Profile'),
          onTap: () {
            // Handle profile button tap
            Navigator.pop(context); // Close the drawer
            // Add your profile page navigation logic here
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.setting_2),
          title: const Text('Settings'),
          onTap: () {
            // Handle settings button tap
            Navigator.pop(context); // Close the drawer
            // Add your settings page navigation logic here
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.logout),
          title: const Text('Logout'),
          onTap: () {
            // Handle logout button tap
            Navigator.pop(context); // Close the drawer
            // Add your logout logic here
          },
        ),
      ],
    ),
  );
}
