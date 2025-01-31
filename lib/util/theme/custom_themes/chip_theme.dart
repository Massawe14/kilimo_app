import 'package:flutter/material.dart';

import '../../constants/colors.dart';

// Light & Dark EChip Themes
class TChipTheme {
  TChipTheme._(); // To avoid creating instances
  
  // Light Theme
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withAlpha(102),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: TColors.accent,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
  
  // Dark Theme
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: TColors.accent,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
