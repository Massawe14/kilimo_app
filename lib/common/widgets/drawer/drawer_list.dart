import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../admin_navigation_menu.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../features/kilimo/screens/legal/privacy_policy_screen.dart';
import '../../../features/kilimo/screens/legal/terms_and_conditions_screen.dart';
import '../../../features/kilimo/screens/officer/agrovet_screen.dart';
import '../../../features/kilimo/screens/officer/recommendation_screen.dart';
import '../../../features/personalization/models/user_modal.dart';
import '../../../features/personalization/screens/feedback/feedback_screen.dart';
import '../../../features/personalization/screens/profile/profile_screen.dart';
import '../../../features/personalization/screens/settings/settings_screen.dart';
import '../../../user_navigation_menu.dart';
import '../../../util/constants/colors.dart';
import '../../../util/constants/sizes.dart';
import '../../../util/constants/text_strings.dart';

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModal>(
      future: UserRepository.instance.fetchUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: TColors.accent),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final user = snapshot.data ?? UserModal.empty();
        final userRole = user.userRole;

        return Container(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            runSpacing: 16,
            children: _buildDrawerItems(context, userRole),
          ),
        );
      },
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context, String userRole) {
    switch (userRole) {
      case 'Farmer':
        return _farmerDrawerItems(context);
      case 'Extension Officer':
        return _extensionOfficerDrawerItems(context);
      default:
        return [
          ListTile(
            leading: const Icon(Iconsax.warning_2, color: Colors.orange),
            title: const Text('Role not set'),
            subtitle: const Text('Please contact admin'),
          )
        ];  
    }
  }

  List<Widget> _farmerDrawerItems(BuildContext context) {
    return [
      ListTile(
        leading: const Icon(Iconsax.home),
        title: Text(TTexts.tMenu1.tr),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const UserNavigationMenu(),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Iconsax.user),
        title: Text(TTexts.tMenu2.tr),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ));
        },
      ),
      const Divider(color: TColors.grey),
      ListTile(
        leading: const Icon(Iconsax.setting_2),
        title: Text(TTexts.tMenu6.tr),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SettingsScreen(),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Iconsax.frame_4),
        title: Text(TTexts.tMenu7.tr),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PrivacyPolicyScreen(),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Iconsax.text_block),
        title: Text(TTexts.tMenu8.tr),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TermsAndConditionsScreen(),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Iconsax.message_question),
        title: Text(TTexts.tMenu9.tr),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FeedBackScreen(),
          ));
        },
      ),
      const SizedBox(height: TSizes.spaceBtwSections),
      const Divider(color: TColors.grey),
      ListTile(
        leading: const Icon(Iconsax.logout, color: TColors.error),
        title: Text(
          TTexts.tMenu10.tr,
          style: const TextStyle(color: TColors.error),
        ),
        onTap: () {
          Navigator.pop(context);
          AuthenticationRepository.instance.logout();
        },
      ),
    ];
  }

  List<Widget> _extensionOfficerDrawerItems(BuildContext context) {
    return [
      // Add the list items specific to the extension officer role here
      ListTile(
        leading: const Icon(Iconsax.home),
        title: Text(TTexts.tMenu1.tr),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AdminNavigationMenu(),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Iconsax.user),
        title: Text(TTexts.tMenu2.tr),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Iconsax.personalcard),
        title: Text(TTexts.tMenu11),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AgrovetScreen(),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Iconsax.document_1),
        title: Text(TTexts.tMenu12),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const RecommendationScreen(),
          ));
        },
      ),
      const Divider(color: TColors.grey),
      ListTile(
        leading: const Icon(Iconsax.logout, color: TColors.error),
        title: Text(
          TTexts.tMenu10.tr,
          style: const TextStyle(color: TColors.error),
        ),
        onTap: () {
          Navigator.pop(context);
          AuthenticationRepository.instance.logout();
        },
      ),
    ];
  }
}
