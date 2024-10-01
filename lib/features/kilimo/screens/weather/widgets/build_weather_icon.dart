// Build weather icon based on icon code
import 'package:flutter/material.dart';

import 'weather_icons.dart';

Widget buildWeatherIcon(String iconCode) {
  return SizedBox(
    width: 50,
    height: 50,
    child: getWeatherIcon(iconCode),
  );
}
