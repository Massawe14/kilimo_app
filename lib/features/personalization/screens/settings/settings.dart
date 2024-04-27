import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimo_app/features/personalization/screens/settings/widgets/section_heading.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/constants/text_strings.dart';
import 'widgets/settings_menu_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // General Settings
                  const TSectionHeading(title: 'General', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Select your language',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextButton(
                    onPressed: () {}, 
                    child: Text(
                      'English', 
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'App country',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextButton(
                    onPressed: () {}, 
                    child: Text(
                      'Tanzania', 
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.moon,
                    title: 'Dark Theme',
                    subTitle: 'Set dark theme',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  // Notifications Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const Divider(color: TColors.grey),
                  const TSectionHeading(title: 'Notifications', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Receive Push Notification',
                    subTitle: 'Information about my crops',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Receive Push Notification',
                    subTitle: 'Popular Posts',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'Receive Push Notification',
                    subTitle: 'Answer to your post',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.moon,
                    title: 'Receive Push Notification',
                    subTitle: 'Upvote to your post',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  // Logout Button
                  const Divider(color: TColors.grey),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        AuthenticationRepository.instance.logout();
                      }, 
                      child: const Text(TTexts.tMenu10, style: TextStyle(color: TColors.error))
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}