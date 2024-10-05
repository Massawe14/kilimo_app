import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/diseases/maize/maize_detection_controller.dart';
import 'disease_details_screen.dart';
import 'widgets/bounding_box_painter.dart';

class MaizeCameraView extends StatelessWidget {
  const MaizeCameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final MaizeDetectionController controller = Get.put(MaizeDetectionController());

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
        title: Text('maize_disease_detection'.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Center(
                    child: controller.isLoading.value
                        ? (controller.imageFile.value != null
                            ? CircularProgressIndicator(
                                color: darkMode ? TColors.white : TColors.black,
                              )
                            : SizedBox(
                                width: 260,
                                child: Padding(
                                  padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('assets/icons/crop_image.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        : Column(
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

                                    return SizedBox(
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
                                          if (highestConfidenceBox != null)
                                            Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Text(
                                                'Highest: ${highestConfidenceBox['name']} (${(highestConfidenceBox['conf'] * 100).toStringAsFixed(2)}%)',
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
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
                                ),
                            ],
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
