import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/sizes.dart';
import '../../controllers/diseases/disease_details_controller.dart';
import '../../models/disease/disease.dart';
import 'widgets/text_property.dart';

class DiseaseDetailsScreen extends StatelessWidget {
  const DiseaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get disease from controller
    final DiseaseDetailsController controller = Get.put(DiseaseDetailsController());

    Disease disease = controller.disease;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Center(
                  child: CircleAvatar(
                    radius: size.width * 0.3,
                    backgroundImage: Image.file(
                      File(disease.imagePath),
                      fit: BoxFit.cover,
                    ).image,
                  ),
                ),
              ),
              Divider(
                thickness: (0.0066 * size.height),
                height: (0.013 * size.height),
              ),
              SizedBox(
                height: size.height * 0.5,
                child: ListView(
                  children: [
                    Text(
                      'Disease Name: ${disease.name}',
                      style: const TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TextProperty(
                      title: 'Symptoms', 
                      items: [disease.symptoms.toString()], 
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TextProperty(
                      title: 'Causes', 
                      items: [disease.causes.toString()],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TextProperty(
                      title: 'Treatment', 
                      items: [disease.treatment.toString()],
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

