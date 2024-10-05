import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../util/constants/api_constants.dart';

// Fetch weekly weather data from OpenWeatherMap API
class WeatherService {
  final String apiKey = APIConstants.tSecretAPIKey;

  Future<Map<String, dynamic>> fetchWeatherByLocation(double lat, double lon) async {
    final String forecastUrl = 
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
    final response = await http.get(Uri.parse(forecastUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
