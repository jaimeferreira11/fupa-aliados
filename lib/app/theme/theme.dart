import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData buildThemeData() {
  return ThemeData(
    fontFamily: "Roboto",
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.accentColor,
    primarySwatch: AppColors.inputColor,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white), // card header text
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor: AppColors.inputColor,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputColor)),
        labelStyle: TextStyle(color: Colors.black87)),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.inputColor,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
