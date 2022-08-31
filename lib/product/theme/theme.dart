import 'package:flutter/material.dart';

import '../consts/color.dart';

class CustomThemeData {
  static ThemeData light(){
    return ThemeData.light(
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
      seedColor: ProjectColors.primaryBlue.value(),
      ),
      splashColor: ProjectColors.primaryBlue.value().withOpacity(0.25),
    );
  }
  static ThemeData dark(){
    return ThemeData.dark(
    );
  }
}
