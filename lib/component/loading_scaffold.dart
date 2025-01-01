import 'package:haruviet/component/loading/over_loading.dart';
import 'package:flutter/material.dart';

class LoadingScaffold extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double? overlayOpacity;
  final Color? overlayBackgroundColor;
  const LoadingScaffold(
      {super.key,
      this.overlayOpacity,
      required this.child,
      required this.isLoading,
      this.overlayBackgroundColor});
  @override
  Widget build(BuildContext context) {
    return LoadingWithAppIcon(
        isLoading: isLoading,
        overlayOpacity: overlayOpacity ?? 0.2,
        overlayBackgroundColor: overlayBackgroundColor,
        borderRadius: 0.2,
        circularProgressColor: Theme.of(context).primaryColor,
        appIcon: Image.asset(
          'assets/logo/logo.png',
          fit: BoxFit.cover,
        ),
        child: child);
  }
}
