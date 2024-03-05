import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimo_app/data/repositories/authentication/authentication_repository.dart';
import 'package:kilimo_app/util/constants/colors.dart';

import '../../../navigation_menu.dart';
import '../../../util/constants/sizes.dart';

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(Iconsax.home),
          title: const Text('Home'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const NavigationMenu())
            );
          }
        ),
        ListTile(
          leading: const Icon(Iconsax.user),
          title: const Text('Profile'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.microphone_2),
          title: const Text('Change Language'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.notification),
          title: const Text('Notifications'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.message_2),
          title: const Text('Messages'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        const Divider(color: TColors.grey),
        ListTile(
          leading: const Icon(Iconsax.setting_2),
          title: const Text('Settings'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.frame_4),
          title: const Text('Privacy Policy'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.text),
          title: const Text('Terms and Conditions'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.message_question),
          title: const Text('Send Feedback'),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        const Divider(color: TColors.grey),
        ListTile(
          leading: const Icon(Iconsax.logout, color: TColors.error),
          title: const Text('Logout', style: TextStyle(color: TColors.error)),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
            AuthenticationRepository.instance.logout();
          },
        ),
      ],
    ),
  );
}
