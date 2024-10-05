import 'dart:ui';

import 'package:get/get.dart';

class ChangeLanguageController extends GetxController {
  void updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }
}
