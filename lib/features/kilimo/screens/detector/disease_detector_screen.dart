import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import 'beans_camera_view_screen.dart';
import 'cassava_camera_view_screen.dart';
import 'maize_camera_view_screen.dart';
import 'rice_camera_view_screen.dart';
import 'widgets/custom_card.dart';

class DiseaseDetectorScreen extends StatelessWidget {
  const DiseaseDetectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('plant_diseases_detector'.tr, style: Theme.of(context).textTheme.headlineMedium),
      ),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MaizeCameraView(),
                          ),
                        );
                      },
                      child: CustomCard(
                        imagePath: TImages.cropImage1, 
                        title: 'maize'.tr,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BeansCameraView(),
                          ),
                        );
                      },
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RiceCameraView(),
                          ),
                        );
                      },
                      child: CustomCard(
                        imagePath: TImages.cropImage3, 
                        title: 'rice'.tr,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CassavaCameraView(),
                          ),
                        );
                      },
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
