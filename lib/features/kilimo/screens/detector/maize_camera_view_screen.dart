import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../controllers/diseases/maize/maize_detection_controller.dart';

class MaizeCameraView extends StatelessWidget {
  const MaizeCameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final MaizeDetectionController controller = Get.put(MaizeDetectionController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
        title: const Text('Maize Disease Detection'),
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
                              if (controller.imageFile.value != null)
                                SizedBox(
                                  width: double.infinity,
                                  height: 300,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.file(controller.imageFile.value!),
                                      ...controller.getBoxes().map((box) {
                                        final rect = box['box'];
                                        final name = box['name'];
                                        final confidence = box['conf'];

                                        return Positioned(
                                          left: rect[0],
                                          top: rect[1],
                                          width: rect[2] - rect[0],
                                          height: rect[3] - rect[1],
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.red, width: 2),
                                            ),
                                            child: Text(
                                              '$name (${(confidence * 100).toStringAsFixed(2)}%)',
                                              style: const TextStyle(
                                                color: Colors.red,
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),
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
