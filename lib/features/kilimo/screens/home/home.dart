import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimo_app/util/constants/colors.dart';
import 'package:kilimo_app/util/constants/sizes.dart';
import 'package:kilimo_app/util/constants/text_strings.dart';

import '../../../../common/styles/shadow.dart';
import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../common/widgets/custom_shapes/t_rounded_image.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/helpers/helper_functions.dart';
import 'widgets/drawer.dart';
import 'widgets/popup_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TTexts.appName,
          style: TextStyle(
            color: TColors.black,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                margin: const EdgeInsets.all(TSizes.spaceBtwItems),
                decoration: BoxDecoration(
                  color: TColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Weather Information'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                boxShadow: [TShadowStyle.verticalProductShadow],
                color: dark ? TColors.darkerGrey : TColors.white,
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              ),
              child: Center(
                child: Column(
                  children: [
                    TRoundedContainer(
                      height: 200,
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: dark ? TColors.dark : TColors.light,
                      child: const Stack(
                        children: [
                          TRoundedImage(
                            imageurl: TImages.cropImage1,
                            applyImageRadius: true,
                          ),
                        ],
                      ),
                    ),
                    // const Image(
                    //   image: AssetImage(TImages.cropImage1),
                    //   height: 200,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                    const Text('Crop Image Description'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                boxShadow: [TShadowStyle.verticalProductShadow],
                color: dark ? TColors.darkerGrey : TColors.white,
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              ),
              child: Center(
                child: Column(
                  children: [
                    TRoundedContainer(
                      height: 200,
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: dark ? TColors.dark : TColors.light,
                      child: const Stack(
                        children: [
                          TRoundedImage(
                            imageurl: TImages.cropImage2,
                            applyImageRadius: true,
                          ),
                        ],
                      ),
                    ),
                    // const Image(
                    //   image: AssetImage(TImages.cropImage1),
                    //   height: 200,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                    const Text('Crop Image Description'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                boxShadow: [TShadowStyle.verticalProductShadow],
                color: dark ? TColors.darkerGrey : TColors.white,
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              ),
              child: Center(
                child: Column(
                  children: [
                    TRoundedContainer(
                      height: 200,
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: dark ? TColors.dark : TColors.light,
                      child: const Stack(
                        children: [
                          TRoundedImage(
                            imageurl: TImages.cropImage3,
                            applyImageRadius: true,
                          ),
                        ],
                      ),
                    ),
                    // const Image(
                    //   image: AssetImage(TImages.cropImage1),
                    //   height: 200,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                    const Text('Crop Image Description'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                boxShadow: [TShadowStyle.verticalProductShadow],
                color: dark ? TColors.darkerGrey : TColors.white,
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              ),
              child: Center(
                child: Column(
                  children: [
                    TRoundedContainer(
                      height: 200,
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: dark ? TColors.dark : TColors.light,
                      child: const Stack(
                        children: [
                          TRoundedImage(
                            imageurl: TImages.cropImage4,
                            applyImageRadius: true,
                          ),
                        ],
                      ),
                    ),
                    // const Image(
                    //   image: AssetImage(TImages.cropImage1),
                    //   height: 200,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                    const Text('Crop Image Description'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
