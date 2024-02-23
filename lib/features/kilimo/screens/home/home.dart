import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimo_app/util/constants/colors.dart';
import 'package:kilimo_app/util/constants/sizes.dart';
import 'package:kilimo_app/util/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Iconsax.menu1,
        ),
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
              Iconsax.setting2,
            ),
            onPressed: () {
              // Handle justify icon action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(TSizes.spaceBtwItems),
              margin: const EdgeInsets.all(TSizes.spaceBtwItems),
              decoration: BoxDecoration(
                color: TColors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Weather Information'),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.network(
                    'https://example.com/crop_image.jpg',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  const Text('Crop Image Description'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
