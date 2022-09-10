import 'package:flutter/material.dart';

import '../consts/color.dart';

class CustomThemeData {
  static ThemeData light(){
    return ThemeData.light(
    ).copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      colorScheme: ColorScheme.fromSeed(
      seedColor: ProjectColors.primaryBlue.value(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ProjectColors.primaryBlue.value())),
      ),
      splashColor: ProjectColors.primaryBlue.value().withOpacity(0.25),
    );
  }
  static ThemeData dark(){
    return ThemeData.dark(
    );
  }
}
