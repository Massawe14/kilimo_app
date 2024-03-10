import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/constants/text_strings.dart';
import '../../../../util/helpers/helper_functions.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

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
                        Iconsax.camera,
                        color: TColors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: TTexts.firstname,
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: TTexts.lastname,
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Username
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: TTexts.username,
                        prefixIcon: Icon(Iconsax.user_edit),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Email
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: TTexts.email,
                        prefixIcon: Icon(Iconsax.direct),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Phone Number
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: TTexts.phoneNo,
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Password
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: TTexts.password,
                        prefixIcon: Icon(Iconsax.password_check),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary, side: BorderSide.none, shape: const StadiumBorder(),
                        ),
                        child: const Text(TTexts.tEditProfile, style: TextStyle(color: TColors.black)),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: TTexts.tJoined,
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                text: TTexts.tJoinedAt,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {}, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                          ),
                          child: const Text(TTexts.tDelete),
                        ),
                      ],
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