import 'package:haruviet/component/loading/over_loading.dart';
import 'package:haruviet/helper/colors.dart';
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
        overlayOpacity: 0.3,
        borderRadius: 0.2,
        circularProgressColor: colorMain,
        appIcon: Image.asset(
          'assets/images/logo_2.png',
          fit: BoxFit.cover,
        ),
        child: child);
  }
}
