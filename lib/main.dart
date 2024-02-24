import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'firebase_options.dart';

// Entry point of Flutter App
void main() async {
  // Initialize Firebase
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository())
  );
  runApp(
    const App(),
  );
}
