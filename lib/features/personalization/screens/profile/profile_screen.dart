import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/constants/text_strings.dart';
import '../../../../util/helpers/helper_functions.dart';
import 'update_profile_screen.dart';
import 'widgets/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Center(child: Text('Profile')),
        actions: [
          IconButton(
            icon: Icon(
              dark? Iconsax.moon : Iconsax.sun_1
            ),
            onPressed: () {
              // Handle change theme icon action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage(TImages.profileImage),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: TColors.primary,
                      ),
                      child: const Icon(
                        Iconsax.edit,
                        color: TColors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(TTexts.username, style: Theme.of(context).textTheme.headlineMedium),
              Text(TTexts.email, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ), 
                  child: const Text(TTexts.tEditProfile, style: TextStyle(color: TColors.dark))
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              // MENU
              ProfileMenuWidget(title: TTexts.tMenu6, icon: Iconsax.setting_2, onPress: () {}, endIcon: true),
              ProfileMenuWidget(title: TTexts.tMenu6, icon: Iconsax.setting_2, onPress: () {}, endIcon: true),
              ProfileMenuWidget(title: TTexts.tMenu6, icon: Iconsax.setting_2, onPress: () {}, endIcon: true),
              const Divider(color: TColors.grey),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: TTexts.tMenu6, icon: Iconsax.setting_2, onPress: () {}, endIcon: true),
              ProfileMenuWidget(
                title: TTexts.tMenu10, 
                icon: Iconsax.logout, 
                textColor: TColors.error,
                onPress: () {
                  AuthenticationRepository.instance.logout();
                }, 
                endIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
