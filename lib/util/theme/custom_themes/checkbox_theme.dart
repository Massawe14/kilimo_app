import 'package:flutter/material.dart';

import '../../constants/colors.dart';

// Light & Dark Check Box Themes
class TCheckboxTheme {
  TCheckboxTheme._(); // To avoid creating instances
  
  // Light Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return TColors.accent;
      } else {
        return Colors.transparent;
      }
    }),
  );
  
  // Dark Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return TColors.accent;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
