import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../../services/location_service.dart';
import '../../services/tensorflow_service.dart';
import '../../services/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  late Interpreter interpreter;
  final RxList<double> temperatures = List<double>.filled(7, 0.0).obs;
  final RxList<double> humidities = List<double>.filled(7, 0.0).obs;
  final RxList<double> precipitations = List<double>.filled(7, 0.0).obs;
  final RxString prediction = ''.obs;
  List<String> labels = [];

  var isModelLoaded = false.obs;
  var areLabelsLoaded = false.obs;
  var isLoading = false.obs; // Loading state to control the UI

  @override
  void onInit() {
    super.onInit();
    loadModel();
    loadLabels();
    fetchWeatherData();
  }

  // Load the TFLite model from assets
  void loadModel() {
    TensorFlowService.loadModelWithFlexDelegate();
    isModelLoaded.value = true;
  }

  // Load labels for predictions from assets
  void loadLabels() async {
    try {
      final String labelData = await rootBundle.loadString('assets/models/labels.txt');
      labels = labelData.split('\n').map((e) => e.trim()).toList();
      areLabelsLoaded.value = true;
      debugPrint('Labels loaded successfully');
    } catch (e) {
      debugPrint('Error loading labels: $e');
    }
  }

  // Fetch weather data (7-day forecast) and prepare input for prediction
  void fetchWeatherData() async {
    isLoading.value = true; // Show loading indicator when fetching data
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        final weatherData = await _weatherService.fetchWeatherByLocation(position.latitude, position.longitude);
        
        // Extracting data for the next 7 days
        for (int i = 0; i < 7; i++) {
          final dailyData = weatherData['list'][i];

          // Explicitly convert to double
          temperatures[i] = (dailyData['main']['temp'] is int)
            ? (dailyData['main']['temp'] as int).toDouble()
            : dailyData['main']['temp'];

          humidities[i] = (dailyData['main']['humidity'] is int)
            ? (dailyData['main']['humidity'] as int).toDouble()
            : dailyData['main']['humidity'];

          precipitations[i] = dailyData['rain'] != null
            ? (dailyData['rain'].containsKey('3h')
              ? (dailyData['rain']['3h'] is int
                ? (dailyData['rain']['3h'] as int).toDouble()
                : dailyData['rain']['3h'])
              : 0.0)
            : 0.0;
        }

        if (isModelLoaded.value && areLabelsLoaded.value) {
          prediction.value = '';  // Clear previous predictions
          predictCropDisease();
        } else {
          debugPrint('Model or labels not loaded yet');
        }
      } else {
        debugPrint('Unable to retrieve location');
      }
    } catch (e) {
      debugPrint('Error fetching weather data: $e');
    } finally {
      isLoading.value = false; // Hide loading indicator after fetching data
    }
  }

  // Compute average values and perform one prediction
  void predictCropDisease() async {
    // Calculate the average weather data over 7 days
    double avgTemperature = temperatures.reduce((a, b) => a + b) / temperatures.length;
    double avgHumidity = humidities.reduce((a, b) => a + b) / humidities.length;
    double avgPrecipitation = precipitations.reduce((a, b) => a + b) / precipitations.length;

    var input = [
      [
        [
          normalizeTemperature(avgTemperature), 
          normalizeHumidity(avgHumidity), 
          normalizePrecipitation(avgPrecipitation),
        ]
      ]
    ];

    // Call the predict method in TensorFlowService
    var output = await TensorFlowService.predict(input);

    if (output != null) {
      int predictedIndex = output.indexWhere((element) => element == output.reduce((a, b) => a > b ? a : b));
      prediction.value = "Predicted Crop Disease: ${labels[predictedIndex]}"; // Return a single prediction
    } else {
      debugPrint('Prediction failed');
    }
  }

  double normalizeTemperature(double temp) {
    const double minTemp = -10.0;
    const double maxTemp = 50.0;
    return (temp - minTemp) / (maxTemp - minTemp);
  }

  double normalizeHumidity(double humidity) {
    return humidity / 100.0;
  }

  double normalizePrecipitation(double precipitation) {
    const double maxPrecipitation = 100.0; // Set this based on your dataset
    return precipitation / maxPrecipitation;
  }
}
