import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';

const ColorScheme lightColorScheme = ColorScheme(
  primary: Color(0xFFB93C5D),
  onPrimary: Colors.black,
  secondary: Color(0xFFEFF3F3),
  onSecondary: Color(0xFF322942),
  error: Colors.redAccent,
  onError: Colors.white,
  background: Color(0xFFebeff8),
  onBackground: Colors.white,
  surface: Color(0xFFFAFBFB),
  onSurface: Color(0xFF241E30),
  brightness: Brightness.light,
);

// color scheme default customization for haruviet
ColorScheme myColorScheme = const ColorScheme(
  primaryContainer: colorMainCover,
  // color main app
  primary: colorMain,
  // color for buttons and text cover

  secondary: colorMainCover,
  surface: Color.fromARGB(255, 134, 144, 163),
  background: colorWhite,
  error: Colors.red,
  onPrimary: Colors.white,
  onError: Colors.white,
  brightness: Brightness.light,
  onSecondary: Colors.green,
  onSurface: Color.fromARGB(255, 134, 144, 163),
  onBackground: Color.fromARGB(255, 157, 41, 183),
);
// Color background = const Color.fromARGB(255, 221, 221, 221);
Color backgroundList = const Color.fromARGB(255, 221, 221, 221);

const ColorScheme darkColorScheme = ColorScheme(
  primary: Color(0xFFFF8383),
  secondary: Color(0xFF4D1F7C),
  background: Color(0xFF241E30),
  surface: Color(0xFF1F1929),
  onBackground: Color(0x0DFFFFFF),
  error: Colors.redAccent,
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  brightness: Brightness.dark,
);
