import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../detector/real_time_detection_screen.dart';
import 'widgets/crop_summary_app_bar.dart';

class MaizeSummaryScreen extends StatelessWidget {
  const MaizeSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const CropSummaryAppBar(image: 'assets/images/crops/maize.jpeg'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4.0),
                  Text(
                    'Maize',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Maize is a cereal grain that was first domesticated by indigenous peoples in southern Mexico about 10,000 years ago. The leafy stalk of the plant produces pollen inflorescences and separate ovuliferous inflorescences called ears that yield kernels or seeds, which are fruits.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Planting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize is a warm-season crop, it should be planted when the soil temperature is between 60-95°F. The ideal soil temperature for germination is 86°F. Maize is a heavy feeder and requires a lot of nutrients. It is recommended to plant maize in a well-drained soil with a pH of 6.0-7.0.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Harvesting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize is ready for harvest when the kernels are hard and the husks are dry. The best way to determine if maize is ready for harvest is to check the moisture content of the kernels. The moisture content should be between 20-25%. Maize can be harvested by hand or by using a combine harvester.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Storage',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize should be stored in a cool, dry place to prevent mold growth. The ideal storage temperature for maize is between 50-60°F. Maize should be stored in a well-ventilated area to prevent moisture buildup. Maize can be stored in airtight containers or in a silo.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Pests and Diseases',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize is susceptible to a number of pests and diseases. Some common pests that affect maize include corn earworm, cutworm, and corn borer. Some common diseases that affect maize include gray leaf spot, northern corn leaf blight, and common rust. It is important to monitor maize for pests and diseases and take appropriate action to control them.',
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
                    'The market price of maize can vary depending on the region and the time of year. It is important to monitor the market price of maize to ensure that you are getting a fair price for your crop. Some factors that can affect the market price of maize include supply and demand, weather conditions, and government policies. It is recommended to sell maize when the market price is high to maximize your profit.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Climate Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize is a warm-season crop that requires a lot of sunlight and heat to grow. It is recommended to plant maize when the soil temperature is between 60-95°F. Maize is also a heavy feeder and requires a lot of nutrients. It is important to plant maize in a well-drained soil with a pH of 6.0-7.0. Maize is susceptible to frost and should be planted after the last frost date in your area.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Water Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize requires a lot of water to grow. It is recommended to plant maize in a well-drained soil with good water-holding capacity. Maize should be watered regularly to ensure that the soil is moist but not waterlogged. It is important to monitor the soil moisture level and adjust the watering schedule as needed. Maize should be watered in the morning or evening to reduce water loss due to evaporation.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Soil Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize should be planted in a well-drained soil with good water-holding capacity. It is recommended to plant maize in a soil with a pH of 6.0-7.0. Maize is a heavy feeder and requires a lot of nutrients. It is important to fertilize the soil before planting maize to ensure that the plants have enough nutrients to grow. Maize should be planted in a soil that is free of weeds and other pests.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Varieties',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'There are many different varieties of maize available, each with its own unique characteristics. Some common varieties of maize include sweet corn, dent corn, and flint corn. Sweet corn is a popular variety of maize that is known for its sweet taste. Dent corn is a variety of maize that is used for animal feed and industrial purposes. Flint corn is a variety of maize that is known for its hard kernels and is often used for making cornmeal and popcorn.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Diseases',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize is susceptible to a number of diseases, including gray leaf spot, northern corn leaf blight, and common rust. Gray leaf spot is a fungal disease that affects the leaves of maize plants. Northern corn leaf blight is a fungal disease that affects the leaves and stalks of maize plants. Common rust is a fungal disease that affects the leaves of maize plants. It is important to monitor maize for diseases and take appropriate action to control them.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Pests',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize is susceptible to a number of pests, including corn earworm, cutworm, and corn borer. Corn earworm is a common pest that affects the ears of maize plants. Cutworm is a common pest that affects the roots of maize plants. Corn borer is a common pest that affects the stalks of maize plants. It is important to monitor maize for pests and take appropriate action to control them.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Problems',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Maize is susceptible to a number of problems, including poor germination, poor pollination, and poor kernel development. Poor germination can be caused by planting maize in cold, wet soil. Poor pollination can be caused by planting maize in hot, dry weather. Poor kernel development can be caused by planting maize in poor soil or by not providing enough nutrients. It is important to monitor maize for problems and take appropriate action to correct them.',
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
