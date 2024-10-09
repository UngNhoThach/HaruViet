import 'package:flutter/material.dart';

const thin = FontWeight.w100;
const extraLight = FontWeight.w200;
const light = FontWeight.w300;
const regular = FontWeight.w400;
const medium = FontWeight.w500;
const semiBold = FontWeight.w600;
const bold = FontWeight.w700;
const extraBold = FontWeight.w800;
const ultraBold = FontWeight.w900;

const textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 54,
  ),
  displayMedium: TextStyle(fontSize: 42),
  displaySmall: TextStyle(fontSize: 34),
  headlineLarge: TextStyle(fontSize: 30),
  headlineMedium: TextStyle(fontSize: 26),
  headlineSmall: TextStyle(fontSize: 22),
  titleLarge: TextStyle(fontSize: 18, fontWeight: bold),
  titleMedium: TextStyle(fontSize: 16, fontWeight: bold),
  titleSmall: TextStyle(fontSize: 16, fontWeight: semiBold),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: semiBold),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: medium),
  bodySmall: TextStyle(fontSize: 12, fontWeight: regular),
  labelLarge: TextStyle(fontSize: 14, fontWeight: regular),
  labelMedium: TextStyle(fontSize: 12, fontWeight: regular),
  labelSmall: TextStyle(fontSize: 10, fontWeight: regular),
);
