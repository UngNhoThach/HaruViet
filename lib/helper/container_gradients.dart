import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static LinearGradient verticalGradient(Color color) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        color.withOpacity(0.8), // Start with a darker shade
        color.withOpacity(0.1), // Fade to a lighter shade
      ],
    );
  }
}
