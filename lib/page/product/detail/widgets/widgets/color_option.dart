import 'package:flutter/material.dart';

enum ColorWorkPlan {
  color40BC86('#40bc86'),
  color2980B9('#2980b9'),
  color00F0FF('#00f0ff'),
  colorFCB410('#fcb410'),
  colorEC555C('#ec555c'),
  colorBF4ACC('#bf4acc');

  const ColorWorkPlan(this.value);

  final String value;

  static ColorWorkPlan from(String? value) {
    return ColorWorkPlan.values.firstWhere(
      (element) => element.value == value,
      orElse: () => ColorWorkPlan.colorBF4ACC,
    );
  }

  Color get data {
    switch (this) {
      case ColorWorkPlan.color40BC86:
        return const Color(0xFF40BC86);
      case ColorWorkPlan.color2980B9:
        return const Color(0xFF2980B9);
      case ColorWorkPlan.color00F0FF:
        return const Color(0xFF00F0FF);
      case ColorWorkPlan.colorFCB410:
        return const Color(0xFFFCB410);
      case ColorWorkPlan.colorEC555C:
        return const Color(0xFFEC555C);
      case ColorWorkPlan.colorBF4ACC:
        return const Color(0xFFBF4ACC);
    }
  }
}
