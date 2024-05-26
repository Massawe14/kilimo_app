import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/disease_details_controller.dart';
import 'widgets/text_property.dart';

class DiseaseDetailsScreen extends StatelessWidget {
  const DiseaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get disease from controller
    Get.put(DiseaseDetailsController());

    final darkMode = THelperFunctions.isDarkMode(context);

    // Disease? disease = controller.disease;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left, 
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: const Text('Disease Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: GetBuilder<DiseaseDetailsController>(
            builder: (controller) {
              if (controller.disease != null) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Center(
                          child: CircleAvatar(
                            radius: size.width * 0.3,
                            backgroundImage: Image.file(
                              File(controller.disease!.imagePath),
                              fit: BoxFit.cover,
                            ).image,
                          ),
                        ),
                      ),
                      const Divider(color: TColors.grey),
                      SizedBox(
                        height: size.height * 0.5,
                        child: ListView(
                          children: [
                            Text(
                              'Disease Name: ${controller.disease!.name}',
                              style: const TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            TextProperty(
                              title: 'Symptoms', 
                              items: [controller.disease!.symptoms.toString()], 
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            TextProperty(
                              title: 'Causes', 
                              items: [controller.disease!.causes.toString()],
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            TextProperty(
                              title: 'Treatment', 
                              items: [controller.disease!.treatment.toString()],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text(controller.errorMessage ?? 'Error loading disease data'));
              }
            },
          ),
        ),
      ),
    );
  }
}

