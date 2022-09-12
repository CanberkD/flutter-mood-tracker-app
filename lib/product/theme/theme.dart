import 'package:flutter/material.dart';

import '../consts/color.dart';

class CustomThemeData {
  ThemeData light(){
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      colorScheme: ColorScheme.fromSeed(
      seedColor: ProjectColors.primaryBlue.value(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ProjectColors.primaryBlue.value())),
      ),
      splashColor: ProjectColors.primaryBlue.value().withOpacity(0.25),
      brightness: Brightness.light
    );
  }
  ThemeData dark(){
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      colorScheme: ColorScheme.fromSeed(
      seedColor: ProjectColors.primaryBlue.value(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ProjectColors.primaryBlue.value())),
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(color: ProjectColors.primaryWhite.value()),
      subtitle2: TextStyle(color: ProjectColors.primaryGrey.value()),
    ),
    splashColor: ProjectColors.primaryBlue.value().withOpacity(0.25),
    brightness: Brightness.dark
    );
  }
}
