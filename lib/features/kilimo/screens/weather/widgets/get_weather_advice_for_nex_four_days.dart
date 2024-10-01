import 'package:get/get.dart';

String getWeatherAdviceFromNextFourDays(String weatherDescription) {
  if (['light rain', 'rain', 'shower rain', 'heavy rain'].contains(weatherDescription.toLowerCase())) {
    return 'raining_until_tomorrow'.tr;
  } else {
    return 'no_rain_is_forecast_this_week'.tr;
  }
}
