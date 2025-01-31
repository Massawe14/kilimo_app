import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../detector/real_time_detection_screen.dart';
import 'widgets/crop_summary_app_bar.dart';

class BeansSummaryScreen extends StatelessWidget {
  const BeansSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CropSummaryAppBar(image: 'assets/images/crops/beans.jpeg'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4.0),
                  Text(
                    'Beans',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Beans are a warm-season crop that grows best at temperatures between 70 and 80°F. Beans are a great source of protein, fiber, and vitamins. They are easy to grow and can be grown in a variety of soil types. Beans are a great crop for beginners and experienced gardeners alike.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Planting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans should be planted in well-drained soil that receives full sun. Beans can be planted directly in the garden or started indoors and transplanted. Beans should be planted in rows with 18 inches between plants. Beans should be watered regularly and mulched to retain moisture.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Harvesting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans should be harvested when the pods are plump and the seeds are tender. Beans should be picked regularly to encourage more growth. Beans should be harvested in the morning when the pods are cool. Beans should be stored in a cool, dry place.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Storage',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans should be stored in a cool, dry place. Beans should be stored in a paper bag or a perforated plastic bag. Beans should be stored away from direct sunlight. Beans should be stored in a well-ventilated area.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Pests and Diseases',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans are susceptible to a variety of pests and diseases. Beans should be inspected regularly for signs of pests and diseases. Beans should be treated with insecticides and fungicides as needed. Beans should be planted in well-drained soil to prevent root rot.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Nutritional Value',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize is a good source of carbohydrates, fiber, and protein. It is also rich in vitamins and minerals, including vitamin C, vitamin A, and potassium. Maize is low in fat and cholesterol, making it a healthy food choice. Maize is a staple food in many countries around the world and is an important source of nutrition for millions of people.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Market Prices',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'The market price of beans varies depending on the variety, quality, and location. Beans are a popular crop and are in high demand. Beans are a staple food in many countries and are an important source of nutrition for millions of people. Beans are a versatile crop that can be used in a variety of dishes, including soups, stews, and salads.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Climate Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans are a warm-season crop that grows best at temperatures between 70 and 80°F. Beans require full sun and well-drained soil. Beans are drought-tolerant and can be grown in a variety of soil types. Beans should be watered regularly and mulched to retain moisture.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Water Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans require regular watering to grow and produce well. Beans should be watered deeply and infrequently to encourage deep root growth. Beans should be watered in the morning to prevent disease. Beans should be watered at the base of the plant to prevent wet leaves.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Soil Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans should be planted in well-drained soil that receives full sun. Beans can be grown in a variety of soil types, including sandy, loamy, and clay soils. Beans should be planted in soil with a pH between 6.0 and 7.0. Beans should be planted in soil that is rich in organic matter.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Varieties',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'There are many varieties of beans, including bush beans, pole beans, and runner beans. Bush beans are compact plants that do not require support. Pole beans are climbing plants that require support. Runner beans are climbing plants that produce long pods. Beans come in a variety of colors, including green, yellow, and purple.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Diseases',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans are susceptible to a variety of diseases, including powdery mildew, rust, and blight. Beans should be inspected regularly for signs of disease. Beans should be treated with fungicides as needed. Beans should be planted in well-drained soil to prevent disease.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Pests',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans are susceptible to a variety of pests, including aphids, beetles, and caterpillars. Beans should be inspected regularly for signs of pests. Beans should be treated with insecticides as needed. Beans should be planted in well-drained soil to prevent pests.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Problems',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Beans are susceptible to a variety of problems, including poor germination, poor growth, and poor yield. Beans should be planted in well-drained soil to prevent problems. Beans should be watered regularly and mulched to retain moisture. Beans should be inspected regularly for signs of problems.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    "take_action_if_you_spot_something".tr,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    "take_action_subtitle".tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const RealTimeDetectionScreen()),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 25,
                              height: 25,
                              child: Image(
                                image: AssetImage('assets/icons/detection.png'),
                                color: TColors.white,
                              )
                            ),
                            const SizedBox(width: 5),
                            Text('start_diagnosis'.tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'addition_description'.tr,
                    style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: TColors.kSecondaryTextColor),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
