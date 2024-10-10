import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/weather/weather_controller.dart';
import '../../controllers/weather/weather_forecast_controller.dart';
import 'widgets/build_weather_icon.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherForecastController controller = Get.put(WeatherForecastController());
    final WeatherController weatherController = Get.put(WeatherController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left,
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: Text('weather_forecast'.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${controller.weatherData.value.location},',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            controller.weatherData.value.date,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.weatherData.value.temperature.round()}°C',
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Text(
                                '${controller.weatherData.value.maxTemperature.floor()}°C / ${controller.weatherData.value.minTemperature.round()}°C',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Text(
                                'Wind speed ${controller.weatherData.value.windSpeed} m/s'.tr,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                          buildWeatherIcon(controller.weatherData.value.weatherIconCode.toString()),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.weatherData.value.weatherDescription,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                height: 30,
                                child: Image(
                                  image: AssetImage('assets/icons/humidity.png'),
                                ),
                              ),
                              Text(
                                '${controller.weatherData.value.humidity}%',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // const SizedBox(height: TSizes.spaceBtwItems),
                      // Text(
                      //   getWeatherAdvice(controller.weatherData.value.weatherDescription),
                      //   style: Theme.of(context).textTheme.bodyLarge,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const Divider(color: TColors.grey),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  'next_4_days'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: controller.nextFourDaysWeather.map((weatherData) {
                      return Column(
                        children: [
                          Text(
                            weatherData['date'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          buildWeatherIcon(weatherData['weatherIcon'].toString()),
                          const SizedBox(height: 10),
                          Text(
                            weatherData['temperature'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                // const SizedBox(height: TSizes.spaceBtwSections),
                // Text(
                //   getWeatherAdviceFromNextFourDays(controller.weatherData.value.weatherDescription),
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
                // const SizedBox(height: TSizes.spaceBtwSections),
                // Text(
                //   'pro-tip'.tr,
                //   style: Theme.of(context).textTheme.bodySmall,
                // ),
                // const SizedBox(height: TSizes.spaceBtwItems),
                // Text(
                //   getWeatherAdvice(controller.weatherData.value.weatherDescription),
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const Divider(color: TColors.grey),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  'prediction'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                // Predictions
                Obx(() {
                  if (weatherController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (weatherController.prediction.value.isEmpty) {
                    return const Text('Fetching predictions...');
                  } else {
                    // Display the single prediction in a decorated card
                    return Container(
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: TColors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(
                            width: 0.2,
                            color: TColors.grey,
                          ),
                        ),
                        color: darkMode ? TColors.dark : TColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(TSizes.defaultSpace),
                          child: Text(
                            weatherController.prediction.value,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
