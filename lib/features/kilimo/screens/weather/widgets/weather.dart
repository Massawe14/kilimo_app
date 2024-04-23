import 'package:flutter/material.dart';

class Weather {
  final String location;
  final String date;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final double windSpeed;
  final IconData icon;

  Weather({
    required this.location,
    required this.date,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });
}
