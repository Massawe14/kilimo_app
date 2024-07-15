import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import 'maize_camera_view_screen.dart';
import 'widgets/custom_card.dart';

class RealTimeDetectionScreen extends StatelessWidget {
  const RealTimeDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
        title: Text('detector'.tr),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.notification,
            ),
            onPressed: () {
              // Handle notification icon action
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
            onPressed: () {
              // Show the popup menu when the icon is clicked
              showPopupMenu(context);
            },
          ),
        ],
      ),
      drawer: const NavigationDrawerMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.spaceBtwItems),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MaizeCameraView())
                        );
                      },
                      child: CustomCard(
                        imagePath: TImages.cropImage1, 
                        title: 'maize'.tr,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CustomCard(
                        imagePath: TImages.cropImage2, 
                        title: 'beans'.tr,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CustomCard(
                        imagePath: TImages.cropImage3, 
                        title: 'rice'.tr,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CustomCard(
                        imagePath: TImages.cropImage4, 
                        title: 'cassava'.tr,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
