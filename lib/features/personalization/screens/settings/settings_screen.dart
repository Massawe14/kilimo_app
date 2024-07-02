import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/constants/text_strings.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/language_storage.dart';
import '../../controllers/theme_controller.dart';
import 'widgets/settings_menu_tile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Swahili', 'locale': const Locale('sw', 'TZ')},
  ];

  selectLanguage(BuildContext context) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('choose_a_language'.tr, style: Theme.of(context).textTheme.titleMedium),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint(locale[index]['name']);
                      languageController.updateLanguage(locale[index]['locale']);
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
                'cancel'.tr, 
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
        title: Text('settings'.tr),
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
                    TSectionHeading(title: 'general'.tr, showActionButton: false),
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
                    // const SizedBox(height: TSizes.spaceBtwItems),
                    // Text(
                    //   'App country',
                    //   style: Theme.of(context).textTheme.labelMedium,
                    // ),
                    // TextButton(
                    //   onPressed: () {}, 
                    //   child: Text(
                    //     'Tanzania', 
                    //     style: Theme.of(context).textTheme.bodyMedium,
                    //   ),
                    // ),
                    Obx(
                      () => TSettingsMenuTile(
                        icon: themeController.isDarkMode.value ? Iconsax.sun_1 : Iconsax.moon,
                        title: 'dark_theme'.tr,
                        subTitle: 'set_dark_theme'.tr,
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
                    TSectionHeading(title: 'notifications'.tr, showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'receive_push_notification'.tr,
                      subTitle: 'information'.tr,
                      trailing: Switch(
                        value: false, 
                        onChanged: (value) {},
                        activeColor: TColors.accent,
                      ),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'receive_push_notification'.tr,
                      subTitle: 'posts'.tr,
                      trailing: Switch(
                        value: false, 
                        onChanged: (value) {},
                        activeColor: TColors.accent,
                      ),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.image,
                      title: 'receive_push_notification'.tr,
                      subTitle: 'answer'.tr,
                      trailing: Switch(
                        value: false, 
                        onChanged: (value) {},
                        activeColor: TColors.accent,
                      ),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.moon,
                      title: 'receive_push_notification'.tr,
                      subTitle: 'upvote'.tr,
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
                        child: Text(
                          TTexts.tMenu10.tr, 
                          style: const TextStyle(color: TColors.error),
                        ),
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