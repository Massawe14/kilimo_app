import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../detector/disease_detector_screen.dart';
import 'widgets/crop_summary_app_bar.dart';

class CassavaSummaryScreen extends StatelessWidget {
  const CassavaSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CropSummaryAppBar(image: 'assets/images/crops/cassava.jpeg'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4.0),
                  Text(
                    'Cassava',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Cassava is a major staple crop in Africa, Asia and Latin America. It is a major source of carbohydrates and is grown for its edible root. Cassava is a major source of carbohydrates and is grown for its edible root.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Planting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava is propagated by planting stem cuttings. The cuttings are usually 15-30 cm long and 2.5-5 cm in diameter. The cuttings are planted in furrows or ridges, 10-20 cm deep. The cuttings are planted at an angle of 45 degrees, with the upper end of the cutting planted upwards. The cuttings are planted at a spacing of 1 m x 1 m. The cuttings are planted in rows, with a spacing of 1 m between rows. The cuttings are planted in rows, with a spacing of 1 m between rows. The cuttings are planted in rows, with a spacing of 1 m between rows.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Harvesting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava is harvested by uprooting the entire plant. The roots are then separated from the stems. The roots are then washed and peeled. The roots are then cut into pieces and dried. The dried roots are then ground into flour. The flour is then used to make a variety of food products, such as bread, cakes, biscuits, and noodles.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Storage',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava roots can be stored for up to 3 months. The roots should be stored in a cool, dry place. The roots should be stored in a well-ventilated place. The roots should be stored in a place that is free from pests and diseases. The roots should be stored in a place that is free from pests and diseases. The roots should be stored in a place that is free from pests and diseases.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Pests and Diseases',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava is susceptible to a number of pests and diseases. The most common pests are the cassava mealybug, the cassava green mite, and the cassava whitefly. The most common diseases are cassava mosaic disease, cassava brown streak disease, and cassava bacterial blight. The most common pests are the cassava mealybug, the cassava green mite, and the cassava whitefly. The most common diseases are cassava mosaic disease, cassava brown streak disease, and cassava bacterial blight.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Nutritional Value',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava is a good source of carbohydrates, dietary fiber, and vitamins. It is low in fat and cholesterol. It is also a good source of minerals, such as iron, magnesium, and potassium. Cassava is a good source of carbohydrates, dietary fiber, and vitamins. It is low in fat and cholesterol. It is also a good source of minerals, such as iron, magnesium, and potassium.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Market Prices',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'The market price of cassava varies depending on the region and the time of year. The price of cassava is usually higher during the dry season, when the supply is low. The price of cassava is usually lower during the rainy season, when the supply is high. The price of cassava is usually higher in urban areas, where the demand is high. The price of cassava is usually lower in rural areas, where the demand is low.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Climate Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava grows best in tropical and subtropical regions. It requires a temperature of 25-30 degrees Celsius. It requires a rainfall of 1000-1500 mm per year. It requires a well-drained soil. It requires a pH of 5.5-6.5. It requires a soil that is rich in organic matter. It requires a soil that is rich in organic matter. It requires a soil that is rich in organic matter.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Water Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava requires a lot of water. It requires a rainfall of 1000-1500 mm per year. It requires a well-drained soil. It requires a pH of 5.5-6.5. It requires a soil that is rich in organic matter. It requires a soil that is rich in organic matter. It requires a soil that is rich in organic matter.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Soil Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava grows best in well-drained soils. It grows best in sandy loam soils',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Varieties',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'There are many varieties of cassava. Some of the common varieties are',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Diseases',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava is susceptible to a number of diseases. Some of the common diseases are',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Pests',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava is susceptible to a number of pests. Some of the common pests are',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Problems',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Cassava is susceptible to a number of problems. Some of the common problems are',
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
                      onPressed: () => Get.to(() => const DiseaseDetectorScreen()),
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
