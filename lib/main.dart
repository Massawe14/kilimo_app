import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'features/personalization/controllers/theme_controller.dart';
import 'features/kilimo/models/disease/disease.dart';
import 'firebase_options.dart';

// Entry point of Flutter App
Future<void> main() async {
  // Ensure Flutter binding and preserve splash screen
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize GetX storage
  await GetStorage.init();

  // Initialize Firebase and Authentication Repository
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform)
    .then((FirebaseApp app) => Get.put(AuthenticationRepository()));

  // Initialize App Check
  await FirebaseAppCheck.instance.activate(
    // Set appleProvider to `AppleProvider.debug`
    androidProvider: AndroidProvider.debug,
  );

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(DiseaseAdapter());
  
  // Open Hive boxes
  await Future.wait([
    Hive.openBox<Disease>('plant_diseases'),
    Hive.openBox('calculations')
  ]);
  
  // Initialize theme controller
  Get.put(ThemeController());
  
  // Run the app
  runApp(const App());
}
