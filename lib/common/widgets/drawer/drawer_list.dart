import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../features/personalization/screens/profile/profile_screen.dart';
import '../../../features/personalization/screens/settings/settings.dart';
import '../../../navigation_menu.dart';
import '../../../util/constants/colors.dart';
import '../../../util/constants/sizes.dart';
import '../../../util/constants/text_strings.dart';

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
          title: const Text(TTexts.tMenu1),
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
          title: const Text(TTexts.tMenu2),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProfileScreen())
            );
          },
        ),
        const Divider(color: TColors.grey),
        ListTile(
          leading: const Icon(Iconsax.setting_2),
          title: const Text(TTexts.tMenu6),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SettingsScreen())
            );
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.frame_4),
          title: const Text(TTexts.tMenu7),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.text_block),
          title: const Text(TTexts.tMenu8),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.message_question),
          title: const Text(TTexts.tMenu9),
          onTap: () {
            // Close navigation drawer before
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        const Divider(color: TColors.grey),
        ListTile(
          leading: const Icon(Iconsax.logout, color: TColors.error),
          title: const Text(TTexts.tMenu10, style: TextStyle(color: TColors.error)),
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
