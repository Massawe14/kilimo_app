import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'util/app.dart';

// Entry point of Flutter App
void main(){
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
