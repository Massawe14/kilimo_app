import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import '../../../../util/constants/api_constants.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  late Position _currentPosition = Position(
    latitude: 0.0, 
    longitude: 0.0, 
    timestamp: DateTime.now(), 
    accuracy: 0.0, 
    altitude: 0.0, 
    altitudeAccuracy: 0.0, 
    heading: 0.0, 
    headingAccuracy: 0.0, 
    speed: 0.0, 
    speedAccuracy: 0.0
  );

  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage = 'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  WeatherFactory wf = WeatherFactory(APIConstants.tSecretAPIKey);

  @override
  void initState() {
    super.initState();
    _checkPermissionAndGetCurrentLocation();
  }

  Future<void> _checkPermissionAndGetCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await _requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      // Handle case where the user denied permission permanently
      debugPrint(_kPermissionDeniedForeverMessage);
    } else {
      debugPrint(_kPermissionGrantedMessage);
      _getCurrentLocation();
    }
  }

  Future<void> _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Handle case where the user denied permission permanently
      debugPrint(_kPermissionDeniedForeverMessage);
    } else if (permission == LocationPermission.denied) {
      // Handle case where the user denied permission
      debugPrint(_kPermissionDeniedMessage);
    } else {
      debugPrint(_kPermissionGrantedMessage);
      _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      // ignore: unnecessary_null_comparison
      child: _currentPosition == null
        ? null
        : FutureBuilder(
            future: wf.currentWeatherByLocation(_currentPosition.latitude, _currentPosition.longitude), 
            builder: (context, AsyncSnapshot<Weather> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Weather weather = snapshot.data!;
                return _buildWeatherCard(weather);
              }
            }
          )
    );
  }

  Widget _buildWeatherCard(Weather weather) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0, // Set elevation to 0 to remove default card shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: TColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      weather.areaName.toString(), 
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Center(
                    child: Text(
                      DateFormat().add_MMMMEEEEd().format(DateTime.now()), 
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: TColors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Text(
                        weather.weatherDescription.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: TSizes.sm),
                      Text(
                        '${weather.temperature!.celsius!.round().toString()}°C',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        'min: ${weather.tempMin!.celsius!.round().toString()}°C / max: ${weather.tempMax!.celsius!.round().toString()}°C',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/clear.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'wind ${weather.windSpeed}m/s',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
