import 'package:flutter/material.dart';

Map<String, Color> colorMap = {
  "Red": Colors.red,
  "Green": Colors.green,
  "Blue": Colors.blue,
  "Yellow": Colors.yellow,
  "White": Colors.white,
};

Color getColorFromName(String colorName) {
  return colorMap[colorName] ?? Colors.black;
}
