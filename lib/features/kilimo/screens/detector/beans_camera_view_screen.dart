import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/beans/beans_detection_controller.dart';
import 'disease_details_screen.dart';
import 'widgets/bounding_box_painter.dart';

class BeansCameraView extends StatelessWidget {
  const BeansCameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final BeansDetectionController controller = Get.put(BeansDetectionController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
        title: Text('beans_disease_detection'.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: darkMode ? TColors.white : TColors.black,
                      ),
                    );
                  } else if (controller.imageFile.value != null) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (controller.imageFile.value != null && controller.detectionResult.value != null)
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final imageSize = Size(
                                  constraints.maxWidth,
                                  constraints.maxHeight,
                                );
                                final boxes = controller.getBoxes(imageSize.width, imageSize.height);
                                final highestConfidenceBox = controller.getHighestConfidenceBox(boxes);

                                return Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 300,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.file(controller.imageFile.value!),
                                          CustomPaint(
                                            painter: ObjectDetectionPainter(boxes),
                                            size: Size.infinite,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (highestConfidenceBox != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: TSizes.spaceBtwItems),
                                        child: Text(
                                          'Most scored detected: ${highestConfidenceBox['name']} - ${(highestConfidenceBox['conf'] * 100).toStringAsFixed(0)}%',
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: TColors.accent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: TSizes.spaceBtwSections),
                            if (controller.imageFile.value != null && controller.detectionResult.value != null && controller.getHighestConfidenceBox(controller.getBoxes(1, 1)) != null)
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(25.5),
                                decoration: BoxDecoration(
                                  color: TColors.accent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Get.to(() => const DiseaseDetailsScreen(), arguments: {
                                      'diseaseName': controller.getHighestConfidenceBox(controller.getBoxes(1, 1))!['name'],
                                    });
                                  },
                                  child: Text(
                                    'recommendations'.tr,
                                    style: const TextStyle(
                                      color: TColors.white,
                                    ),
                                  ),
                                ),
                              )
                            else
                              Center(
                                child: Text(
                                  "No disease detected".tr,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),  
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/crop_image.png',
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          Text(
                            'Upload an image to detect crop diseases.'.tr,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                }),
                const SizedBox(height: TSizes.spaceBtwItems),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(25.5),
                  decoration: BoxDecoration(
                    color: TColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: controller.captureImage,
                    child: Text(
                      'take_a_photo'.tr,
                      style: const TextStyle(
                        color: TColors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(25.5),
                  decoration: BoxDecoration(
                    color: TColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: controller.selectImage,
                    child: Text(
                      'pick_from_gallery'.tr,
                      style: const TextStyle(
                        color: TColors.white,
                      ),
                    ),
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
