import 'package:flutter/material.dart';
import 'package:haruviet/theme/color_scheme.dart';
import 'package:haruviet/theme/typography.dart';

final ThemeData myThemeData = ThemeData(
    useMaterial3: false,
    fontFamily: "SF PRO",
    primaryColorLight: myColorScheme.secondary,
    primaryColor: myColorScheme.primary,
    scaffoldBackgroundColor: myColorScheme.background,
    colorScheme: myColorScheme,
    textTheme: textTheme);
