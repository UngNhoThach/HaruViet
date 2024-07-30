import 'package:haruviet/helper/colors.dart';
import 'package:flutter/material.dart';

class ErrorInternet extends StatelessWidget {
  const ErrorInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorGray01, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
        color: colorWhite,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2.0,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
      child: const Icon(
        Icons.wifi_off_sharp,
        color: colorBlueGray02,
        size: 28.0,
      ),
    );
  }
}
