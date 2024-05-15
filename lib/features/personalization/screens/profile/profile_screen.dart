import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimo_app/common/widgets/loaders/shimmer.dart';

import '../../../../common/widgets/image_text_widget/t_circular_image.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/user_controller.dart';
import '../settings/widgets/section_heading.dart';
import 'widgets/change_name.dart';
import 'widgets/change_phonenumber.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final controller = UserController.instance;
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
        title: const Text('Profile'),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                themeController.isDarkMode.value 
                  ? Iconsax.sun_1 
                  : Iconsax.moon,
              ),
              onPressed: () => themeController.changeTheme(),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                // Profile Picture
                Stack(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : TImages.profileImage;
                      return controller.imageUploading.value
                        ? const TShimmerEffect(width: 80, height: 80, radius: 80)
                        : TCircularImage(image: image, width: 100, height: 100, isNetworkImage: networkImage.isNotEmpty);
                    }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: TColors.accent,
                        ),
                        child: IconButton(
                          icon: const Icon(Iconsax.edit, size: 20),
                          color: TColors.black,
                          onPressed: () => controller.uploadUserProfilePicture(),
                        ),
                      ),
                    ),
                  ],
                ),
                Text('Change Profile Picture', style: Theme.of(context).textTheme.bodySmall),
                // Details
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                const Divider(color: TColors.grey),
                const SizedBox(height: TSizes.spaceBtwItems),
                // Heading Profile Info
                const TSectionHeading(title: 'Profile Information', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                TProfileMenu(
                  title: 'Name', 
                  value: controller.user.value.fullName, 
                  onPressed: () => Get.to(() => const ChangeName()),
                ),
                TProfileMenu(
                  title: 'Username', 
                  value: controller.user.value.username, 
                  onPressed: () => Get.to(() => const ChangeName()),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const Divider(color: TColors.grey),
                const SizedBox(height: TSizes.spaceBtwItems),
                // Heading Profile Info
                const TSectionHeading(title: 'Personal Information', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                TProfileMenu(
                  title: 'User ID', 
                  value: controller.user.value.id, 
                  icon: Iconsax.copy, 
                  onPressed: () {},
                ),
                TProfileMenu(
                  title: 'E-mail', 
                  value: controller.user.value.email, 
                  onPressed: () {}
                ),
                TProfileMenu(
                  title: 'Phone Number', 
                  value: controller.user.value.phoneNumber, 
                  onPressed: () => Get.to(() => const ChangePhoneNumber()),
                ),
                const Divider(color: TColors.grey),
                const SizedBox(height: TSizes.spaceBtwSections),
                Center(
                  child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
