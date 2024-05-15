import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/constants/text_strings.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/theme_controller.dart';
import 'widgets/settings_menu_tile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Swahili', 'locale': const Locale('sw', 'TZ')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  selectLanguage(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('choose_a_language'.tr, style: Theme.of(context).textTheme.titleMedium),
          content: Container(
            color: darkMode ? TColors.dark : TColors.white,
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint(locale[index]['name']);
                      updateLanguage(locale[index]['locale']);
                    },
                    child: Text(locale[index]['name']),
                  ),
                );
              }, 
              separatorBuilder: (context, index) {
                return const Divider(
                  color: TColors.grey,
                );
              }, 
              itemCount: locale.length,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel'.tr, 
                style: const TextStyle(
                  color: TColors.info,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left, 
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'select_your_language'.tr,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        selectLanguage(context);
                      }, 
                      child: Text(
                        'language'.tr, 
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
                    Obx(
                      () => TSettingsMenuTile(
                        icon: themeController.isDarkMode.value ? Iconsax.sun_1 : Iconsax.moon,
                        title: 'Dark Theme',
                        subTitle: 'Set dark theme',
                        trailing: Switch(
                          value: themeController.isDarkMode.value, 
                          onChanged: (value) => themeController.changeTheme(),
                          activeColor: TColors.accent,
                        ),
                      ),
                    ),
                    // Notifications Settings
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(color: TColors.grey),
                    const TSectionHeading(title: 'Notifications', showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'Receive Push Notification',
                      subTitle: 'Information about my crops',
                      trailing: Switch(
                        value: false, 
                        onChanged: (value) {},
                        activeColor: TColors.accent,
                      ),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Receive Push Notification',
                      subTitle: 'Popular Posts',
                      trailing: Switch(
                        value: false, 
                        onChanged: (value) {},
                        activeColor: TColors.accent,
                      ),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.image,
                      title: 'Receive Push Notification',
                      subTitle: 'Answer to your post',
                      trailing: Switch(
                        value: false, 
                        onChanged: (value) {},
                        activeColor: TColors.accent,
                      ),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.moon,
                      title: 'Receive Push Notification',
                      subTitle: 'Upvote to your post',
                      trailing: Switch(
                        value: false, 
                        onChanged: (value) {},
                        activeColor: TColors.accent,
                      ),
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
      ),
    );
  }
}