class Weather {
  final String location;
  final String date;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final double windSpeed;
  final int weatherIconCode;
  final String weatherDescription;

  Weather({
    required this.location,
    required this.date,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherIconCode,
    required this.weatherDescription,
  });
}
