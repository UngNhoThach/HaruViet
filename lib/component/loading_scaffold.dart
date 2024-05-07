import 'package:eco_app/component/loading/over_loading.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:flutter/material.dart';

class LoadingScaffold extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingScaffold(
      {super.key, required this.child, required this.isLoading});
  @override
  Widget build(BuildContext context) {
    return LoadingWithAppIcon(
        isLoading: isLoading,
        circularProgressColor: colorMain,
        appIcon: Image.asset(
          'assets/images/logo_2.png',
          fit: BoxFit.cover,
        ),
        child: child);
  }
}
