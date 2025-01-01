import 'package:flutter/material.dart';
import 'package:haruviet/theme/color_scheme.dart';
import 'package:haruviet/theme/typography.dart';

final ThemeData myThemeData = ThemeData(
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: {
    //     // Use PredictiveBackPageTransitionsBuilder to get the predictive back route transition!
    //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    //   },
    // ),
    useMaterial3: false,
    fontFamily: "SF PRO",
    primaryColorLight: myColorScheme.secondary,
    primaryColor: myColorScheme.primary,
    scaffoldBackgroundColor: myColorScheme.background,
    colorScheme: myColorScheme,
    textTheme: textTheme);
