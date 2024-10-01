import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../../util/constants/api_constants.dart';
import '../../screens/weather/widgets/weather.dart';

class WeatherForecastController extends GetxController {
  var weatherData = Weather(
    location: "Loading...",
    date: "",
    temperature: 0.0,
    minTemperature: 0.0,
    maxTemperature: 0.0,
    humidity: 0,
    windSpeed: 0.0,
    weatherIconCode: 800,
    weatherDescription: "Loading..."
  ).obs;

  var nextFourDaysWeather = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      Position position = await _getCurrentLocation();
      String latitude = position.latitude.toString();
      String longitude = position.longitude.toString();

      // Fetch current weather based on user's location
      String apiKey = APIConstants.tSecretAPIKey;
      String currentWeatherUrl =
        "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";
      var currentWeatherResponse = await http.get(Uri.parse(currentWeatherUrl));
      var currentWeatherData = jsonDecode(currentWeatherResponse.body);

      String location = currentWeatherData['name'] ?? "Unknown Location";
      double temperature = currentWeatherData['main']['temp'];
      double minTemperature = currentWeatherData['main']['temp_min'];
      double maxTemperature = currentWeatherData['main']['temp_max'];
      int humidity = currentWeatherData['main']['humidity'];
      double windSpeed = currentWeatherData['wind']['speed'];
      int weatherIconCode = currentWeatherData['weather'][0]['id'];
      String weatherDescription = currentWeatherData['weather'][0]['description'] ?? "No description available";

      weatherData.value = Weather(
        location: location,
        date: _getFormattedDate(),
        temperature: temperature,
        minTemperature: minTemperature,
        maxTemperature: maxTemperature,
        humidity: humidity,
        windSpeed: windSpeed,
        weatherIconCode: weatherIconCode,
        weatherDescription: weatherDescription,
      );

      // Fetch weather forecast for the next four days
      String forecastUrl =
        "http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";
      var forecastResponse = await http.get(Uri.parse(forecastUrl));
      var forecastData = jsonDecode(forecastResponse.body);

      List<dynamic> weatherList = forecastData['list'];

      nextFourDaysWeather.value = [];

      for (var i = 1; i < 5; i++) {
        var weather = weatherList[i * 8];

        String date = weather['dt_txt'];
        // Parse the date string into a DateTime object
        DateTime dateTime = DateTime.parse(date);

        // Format the DateTime object using DateFormat
        String formattedDate = DateFormat.EEEE().format(dateTime);

        double temperature = weather['main']['temp'];
        int weatherIcon = weather['weather'][0]['id'];
        String description = weather['weather'][0]['description'];
        debugPrint('Weather Icon Code: $weatherIcon');

        // Construct a map with string keys
        nextFourDaysWeather.add({
          'date': formattedDate,
          'temperature': '${temperature.round()}°C',
          'weatherIcon': weatherIcon,
          'description': description, 
        });
      }
    } catch (e) {
      debugPrint("Error fetching weather data: $e");
    }
  }

  Future<Position> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      debugPrint("Error getting current location: $e");
      rethrow;
    }
  }

  String _getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, MMMM d').format(now);
  }
}
