import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/theme/theme.dart';
import 'bindings/general_bindings.dart';
import 'features/personalization/controllers/theme_controller.dart';
import 'localization/local_string.dart';
import 'util/constants/colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    
    return GetMaterialApp(
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      locale: const Locale('en', 'US'),
      translations: LocalString(),
      fallbackLocale: const Locale('en', 'US'),
      // Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen
      home: const Scaffold(
        backgroundColor: TColors.grey,
        body: Center(
          child: CircularProgressIndicator(
            color: TColors.primary,
          ),
        ),
      ),
    );
  }
}
