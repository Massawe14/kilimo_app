import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../detector/disease_detector_screen.dart';
import 'widgets/crop_summary_app_bar.dart';

class RiceSummaryScreen extends StatelessWidget {
  const RiceSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CropSummaryAppBar(image: 'assets/images/crops/rice.jpeg'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4.0),
                  Text(
                    'Rice',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Rice is the seed of the grass species Oryza sativa (Asian rice) or less commonly Oryza glaberrima (African rice). As a cereal grain, it is the most widely consumed staple food for a large part of the world\'s human population, especially in Asia and Africa. It is the agricultural commodity with the third-highest worldwide production, after sugarcane and maize.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Planting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice is best grown in flooded fields, though it can also be grown in dry fields. The water helps to control weeds, but it also provides the rice with nutrients. The rice plant is an annual grass that produces round, edible grains. The rice plant can grow to 1–1.8 m (3.3–5.9 ft) tall, occasionally more depending on the variety and soil fertility.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Harvesting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice is harvested when the grains have a moisture content of about 25%. The rice is then threshed to separate the grains from the stalks. The grains are then dried to a moisture content of about 14% before being stored or milled. Rice can be stored for long periods of time without spoiling, making it an important food source for many people around the world.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Storage',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice should be stored in a cool, dry place to prevent spoilage. It should be stored in airtight containers to prevent insects and rodents from getting into it. Rice can be stored for long periods of time without spoiling, making it an important food source for many people around the world.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Pests and Diseases',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice is susceptible to a number of pests and diseases. Some of the most common pests include the rice weevil, the rice moth, and the rice bug. Some of the most common diseases include rice blast, sheath blight, and bacterial leaf blight. These pests and diseases can cause significant damage to rice crops, so it is important to monitor them closely and take steps to control them when necessary.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Nutritional Value',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice is a good source of carbohydrates, which provide the body with energy. It is also a good source of vitamins and minerals, including vitamin B1, vitamin B3, iron, and magnesium. Rice is low in fat and cholesterol, making it a healthy food choice for many people. It is also gluten-free, making it a good option for people with celiac disease or gluten sensitivity.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Market Prices',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'The price of rice can vary depending on the variety, quality, and location. In general, rice prices tend to be higher in urban areas than in rural areas. The price of rice can also be affected by factors such as weather, government policies, and international trade. It is important to monitor rice prices closely to ensure that you are getting a fair price for your crop.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Climate Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice is a tropical crop that requires warm temperatures and high humidity to grow. It is best grown in flooded fields, though it can also be grown in dry fields. Rice requires a lot of water to grow, so it is important to plant it in an area with a reliable water source. Rice is also sensitive to cold temperatures, so it is best grown in areas with a long growing season.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Soil Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice grows best in well-drained, fertile soil that is rich in organic matter. It prefers a soil pH of 6.0–6.5. Rice is sensitive to salinity, so it is important to plant it in an area with low salt levels. Rice is also sensitive to heavy metals, so it is important to plant it in an area with low heavy metal levels. Rice is a heavy feeder, so it is important to fertilize it regularly to ensure good growth and yield.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Water Requirements',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice requires a lot of water to grow, so it is important to plant it in an area with a reliable water source. It is best grown in flooded fields, though it can also be grown in dry fields. Rice is sensitive to drought, so it is important to provide it with enough water to ensure good growth and yield. Rice is also sensitive to waterlogging, so it is important to plant it in an area with good drainage.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Varieties',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'There are thousands of rice varieties grown around the world. Some of the most common varieties include basmati, jasmine, and arborio. Basmati rice is a long-grain rice that is known for its nutty flavor and fragrant aroma. Jasmine rice is a long-grain rice that is known for its floral aroma and soft texture. Arborio rice is a short-grain rice that is known for its creamy texture and ability to absorb flavors well.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Diseases',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice is susceptible to a number of diseases, including rice blast, sheath blight, and bacterial leaf blight. Rice blast is a fungal disease that can cause significant damage to rice crops. Sheath blight is a fungal disease that can cause the leaves of the rice plant to turn brown and die. Bacterial leaf blight is a bacterial disease that can cause the leaves of the rice plant to turn yellow and die. It is important to monitor rice crops closely for signs of disease and take steps to control them when necessary.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Pests',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice is susceptible to a number of pests, including the rice weevil, the rice moth, and the rice bug. The rice weevil is a small beetle that can cause damage to stored rice. The rice moth is a small moth that can cause damage to stored rice. The rice bug is a small insect that can cause damage to rice crops in the field. It is important to monitor rice crops closely for signs of pests and take steps to control them when necessary.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Common Problems',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Rice is susceptible to a number of problems, including nutrient deficiencies, waterlogging, and lodging. Nutrient deficiencies can cause the leaves of the rice plant to turn yellow and die. Waterlogging can cause the roots of the rice plant to rot. Lodging can cause the rice plant to fall over, reducing yield. It is important to monitor rice crops closely for signs of problems and take steps to correct them when necessary.',
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
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
