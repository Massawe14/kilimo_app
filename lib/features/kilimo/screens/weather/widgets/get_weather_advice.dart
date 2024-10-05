import 'package:get/get.dart';

String getWeatherAdvice(String weatherDescription) {
  if (['light rain', 'rain', 'shower rain', 'heavy rain'].contains(weatherDescription.toLowerCase())) {
    return 'bad_day'.tr;
  } else {
    return 'good_day'.tr;
  }
}
