import 'package:haruviet/helper/colors.dart';
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
                'assets/logo/logo.png',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
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
