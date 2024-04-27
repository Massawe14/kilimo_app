import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../controllers/weather/weather_forecast_controller.dart';
import 'widgets/weather_icons.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherForecastController controller = Get.put(WeatherForecastController());
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Weather Forecast'),
      ),
      body: SingleChildScrollView(
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
                              'Wind speed ${controller.weatherData.value.windSpeed}m/s',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: getWeatherIcon(controller.weatherData.value.weatherIconCode.toString()),
                        ),
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
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text(
                      getWeatherAdvice(controller.weatherData.value.weatherDescription),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(color: TColors.grey),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Next 4 days',
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
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: getWeatherIcon(weatherData['weatherIcon'].toString()),
                        ),
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
              const SizedBox(height: TSizes.spaceBtwSections),
              Text(
                'Raining until tomorrow',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Text(
                'Pro-tip',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'WEDNESDAY would be a bad day for: APPLYING PESTICIDES',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getWeatherAdvice(String weatherDescription) {
    if (['light rain', 'rain', 'shower rain', 'heavy rain'].contains(weatherDescription.toLowerCase())) {
      return 'Today would be a bad day for: APPLYING PESTICIDES';
    } else {
      return 'Today would be a good day for: APPLYING PESTICIDES';
    }
  }
}
