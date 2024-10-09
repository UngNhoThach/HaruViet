import 'package:haruviet/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  static void showTop(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_SHORT,
      webPosition: 'top',
    );
  }
}
