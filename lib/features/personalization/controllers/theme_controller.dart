import 'package:get/get.dart';

import '../../../util/theme/theme.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs; // Reactive variable to track the theme mode

  void changeTheme() {
    isDarkMode.value = !isDarkMode.value; // Toggle the theme
    Get.changeTheme(isDarkMode.value ? TAppTheme.darkTheme : TAppTheme.lightTheme); // Update theme in GetX
  }
}
