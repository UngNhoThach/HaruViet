import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, int? secondsShow) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          duration: Duration(seconds: secondsShow ?? 1)),
    );
  }

  static void showTop(BuildContext context, String message, int? secondsShow) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: secondsShow ?? 1), () {
      overlayEntry.remove();
    });
  }
}
