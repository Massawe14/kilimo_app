import 'package:flutter/material.dart';

Widget getWeatherIcon(String code) {
  switch (code) {
    case '801':
      return const Image(image: AssetImage('assets/icons/lightcloud.png'));
    case '802':
      return const Image(image: AssetImage('assets/icons/scatteredcloud.png'));
    case '803':
      return const Image(image: AssetImage('assets/icons/brokencloud.png'));
    case '804':
      return const Image(image: AssetImage('assets/icons/overcastcloud.png'));
    case '701':
      return const Image(image: AssetImage('assets/icons/mist.png'));
    case '711':
      return const Image(image: AssetImage('assets/icons/smoke.png'));
    case '721':
      return const Image(image: AssetImage('assets/icons/haze.png'));
    case '731':
      return const Image(image: AssetImage('assets/icons/dust.png'));
    case '741':
      return const Image(image: AssetImage('assets/icons/fog.png'));
    case '751':
      return const Image(image: AssetImage('assets/icons/sand.png'));
    case '761':
      return const Image(image: AssetImage('assets/icons/dust.png'));
    case '762':
      return const Image(image: AssetImage('assets/icons/ash.png'));
    case '771':
      return const Image(image: AssetImage('assets/icons/squalls.png'));
    case '781':
      return const Image(image: AssetImage('assets/icons/tornado.png'));
    case '600':
      return const Image(image: AssetImage('assets/icons/light-snow.png'));
    case '601':
      return const Image(image: AssetImage('assets/icons/snow.png'));
    case '602':
      return const Image(image: AssetImage('assets/icons/heavy-snow.png'));
    case '611':
      return const Image(image: AssetImage('assets/icons/sleet.png'));
    case '612':
      return const Image(image: AssetImage('assets/icons/light-sleet.png'));
    case '613':
      return const Image(image: AssetImage('assets/icons/shower-sleet.png'));
    case '615':
      return const Image(image: AssetImage('assets/icons/rain-snow.png'));
    case '616':
      return const Image(image: AssetImage('assets/icons/rain-snow.png'));
    case '620':
      return const Image(image: AssetImage('assets/icons/shower-snow.png'));
    case '621':
      return const Image(image: AssetImage('assets/icons/shower-snow.png'));
    case '622':
      return const Image(image: AssetImage('assets/icons/heavy-snow.png'));
    case '500':
      return const Image(image: AssetImage('assets/icons/light-rain.png'));
    case '501':
      return const Image(image: AssetImage('assets/icons/moderate-rain.png'));
    case '502':
      return const Image(image: AssetImage('assets/icons/heavy-rain.png'));
    case '503':
      return const Image(image: AssetImage('assets/icons/very-heavy-rain.png'));
    case '504':
      return const Image(image: AssetImage('assets/icons/extreme-rain.png'));
    case '511':
      return const Image(image: AssetImage('assets/icons/freezing-rain.png'));
    case '520':
      return const Image(image: AssetImage('assets/icons/light-intensity-shower-rain.png'));
    case '521':
      return const Image(image: AssetImage('assets/icons/showersrain.png'));
    case '522':
      return const Image(image: AssetImage('assets/icons/heavy-intensity-shower-rain.png'));
    case '531':
      return const Image(image: AssetImage('assets/icons/ragged-shower-rain.png'));
    case '300':
      return const Image(image: AssetImage('assets/icons/light-drizzle.png'));
    case '301':
      return const Image(image: AssetImage('assets/icons/drizzle.png'));
    case '302':
      return const Image(image: AssetImage('assets/icons/heavy-drizzle.png'));
    case '310':
      return const Image(image: AssetImage('assets/icons/light-drizzle.png'));
    case '311':
      return const Image(image: AssetImage('assets/icons/drizzle-rain.png'));
    case '312':
      return const Image(image: AssetImage('assets/icons/heavy-drizzle-rain.png'));
    case '313':
      return const Image(image: AssetImage('assets/icons/shower-drizzle-rain.png'));
    case '314':
      return const Image(image: AssetImage('assets/icons/heavy-shower-drizzle-rain.png'));
    case '321':
      return const Image(image: AssetImage('assets/icons/shower-drizzle.png'));
    case '200':
      return const Image(image: AssetImage('assets/icons/light-thunderstorm-rain.png'));
    case '201':
      return const Image(image: AssetImage('assets/icons/light-thunderstorm-rain.png'));
    case '202':
      return const Image(image: AssetImage('assets/icons/thunderstorm-heavy-rain.png'));
    case '210':
      return const Image(image: AssetImage('assets/icons/light-thunderstorm.png'));
    case '211':
      return const Image(image: AssetImage('assets/icons/thunderstorm.png'));
    case '212':
      return const Image(image: AssetImage('assets/icons/heavy-thunderstorm.png'));
    case '221':
      return const Image(image: AssetImage('assets/icons/heavy-thunderstorm.png'));
    case '230':
      return const Image(image: AssetImage('assets/icons/light-thunderstorm-rain.png'));
    case '231':
      return const Image(image: AssetImage('assets/icons/light-thunderstorm-rain.png'));
    case '232':
      return const Image(image: AssetImage('assets/icons/thunderstorm-heavy-rain.png'));
    default:
      return const Image(image: AssetImage('assets/icons/clear-sky.png'));
  }
}
