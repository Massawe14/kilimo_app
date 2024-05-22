import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'features/kilimo/models/fertilizer/fertilizer_calculation.dart';
import 'features/personalization/controllers/theme_controller.dart';
import 'features/kilimo/models/disease/disease.dart';
import 'firebase_options.dart';

// Entry point of Flutter App
Future<void> main() async {
  // GetX Local storage
  await GetStorage.init();

  // Widget Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Await Splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  // Initialize App Check
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  // );

  // Initialize Hive
  await Hive.initFlutter();

  // Register HiveAdapter for Disease class
  Hive.registerAdapter(DiseaseAdapter());
  
  // Register HiveAdapter for FertilizerCalculation class
  Hive.registerAdapter(FertilizerCalculationAdapter());

  // Open the box
  await Hive.openBox<Disease>('plant_diseases');

  await Hive.openBox('calculations');
  
  // Initialize theme controller
  Get.put(ThemeController());

  runApp(const App());
}
