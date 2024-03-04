import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import '../home/widgets/drawer.dart';
import '../home/widgets/popup_menu.dart';
import 'widgets/custom_card.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Survey')),
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
        child: Container(
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomCard(imagePath: TImages.cropImage1, title: 'Maize'),
                  CustomCard(imagePath: TImages.cropImage2, title: 'Beans'),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomCard(imagePath: TImages.cropImage3, title: 'Rice'),
                  CustomCard(imagePath: TImages.cropImage4, title: 'Cassava'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
