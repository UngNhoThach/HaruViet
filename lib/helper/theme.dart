import 'package:haruviet/config.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:flutter/material.dart';

final ThemeData myThemeData = ThemeData(
  useMaterial3: false,
  fontFamily: "SF PRO",
//  colorScheme: myColorScheme,
  primarySwatch:
      Colors.blue, // Update this to your desired color (e.g., Colors.green)
  colorScheme: myColorScheme,

  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: colorText,
      // fontSize: 44,
      // height: 52,
      // letterSpacing: 0,
      //    fontWeight: FontWeight.normal,
    ),
    displayMedium: TextStyle(
      color: colorText,
      // fontSize: 40,
      // height: 48,
      // letterSpacing: 0,
      // fontWeight: FontWeight.normal,
    ),
    displaySmall: TextStyle(
      color: colorText,
      // fontSize: 36,
      // height: 44,
      // letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    headlineLarge: TextStyle(
      color: colorText,
      fontSize: 32,
      // height: 40,
      // letterSpacing: 0,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: colorText,
      fontSize: 28,
      // height: 36,
      // letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      color: colorText,
      fontSize: 24,
      // height: 28,
      // letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: colorText,
      fontSize: 18,
      // height: 20,
      // letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: colorText,
      fontSize: 14,
      // height: 20,
      // letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: colorText,
      // fontSize: 14,
      // height: 20,
      // letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: colorText,
      // fontSize: 16,
      // height: 24,
      // letterSpacing: 0.15,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: colorText,
      // fontSize: 84,
      // height: 20,
      // letterSpacing: 0.1,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      color: colorText,
      // fontSize: 12,
      // height: 16,
      // letterSpacing: 0.4,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      color: colorText,
      // fontSize: 14,
      // height: 20,
      // letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: colorText,
      // fontSize: 12,
      // height: 16,
      // letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: colorText,
      // fontSize: 11,
      // height: 16,
      // letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
  ),
);
