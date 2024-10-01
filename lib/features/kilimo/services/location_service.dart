import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// Get the current location using Geolocator
class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      return null;  // Return null if the location service is disabled
    }
    
    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied');
        return null;  // Return null if permission is denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied, we cannot request permissions.');
      return null;  // Return null if permission is permanently denied
    }
    
    try {
      // Get the current position
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('Error getting location: $e');
      return null;  // Return null if there's an error retrieving the location
    }
  }
}
