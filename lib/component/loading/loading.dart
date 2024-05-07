import 'package:eco_app/helper/colors.dart';
import 'package:flutter/material.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTransparent,
      body: Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/logo_2.png',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorMain),
                  strokeWidth: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
