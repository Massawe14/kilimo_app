import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import 'cultivation_tips_menu_tile.dart';

class ContainerSlider extends StatefulWidget {
  const ContainerSlider({super.key});

  static bool _showDefaultContainer = true;

  static void updateShowDefault(bool value) {
    _showDefaultContainer = value;
  }

  @override
  ContainerSliderState createState() => ContainerSliderState();
}

class ContainerSliderState extends State<ContainerSlider> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: ContainerSlider._showDefaultContainer
        ? const DefaultContainer()
        : const GreyButtonContainer(),
    );
  }
}

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: TColors.white,
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Plant Selection',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Planting',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Plant Training',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Monitoring',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Site Selection',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Field Preparation',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Weeding',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Integration',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Fertilizer Chemical',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Preventive Measure',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Harvesting',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                    TCultivationTipsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Post Harvest',
                      trailing: Icon(Iconsax.arrow_right_3),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(color: TColors.grey),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GreyButtonContainer extends StatelessWidget {
  const GreyButtonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: TColors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/calender.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      const Center(
                        child: Text('Choose the date your sowing was done or planned.')
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Iconsax.add),
                              Text('Add sowing date to start'),
                            ],
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
      ),
    );
  }
}
