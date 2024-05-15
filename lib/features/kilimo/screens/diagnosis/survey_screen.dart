import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import 'beans_classification_screen.dart';
import 'cassava_classification_screen.dart';
import 'maize_classification_screen.dart';
import 'rice_classification_screen.dart';
import 'widgets/custom_card.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
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
                          builder: (context) => const MaizeDiagnosisScreen())
                        );
                      },
                      child: const CustomCard(imagePath: TImages.cropImage1, title: 'Maize')
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BeansDiagnosisScreen())
                        );
                      },
                      child: const CustomCard(imagePath: TImages.cropImage2, title: 'Beans')
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RiceDiagnosisScreen())
                        );
                      },
                      child: const CustomCard(imagePath: TImages.cropImage3, title: 'Rice')
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CassavaDiagnosisScreen())
                        );
                      },
                      child: const CustomCard(imagePath: TImages.cropImage4, title: 'Cassava')
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
