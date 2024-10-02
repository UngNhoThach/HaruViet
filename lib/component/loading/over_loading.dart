import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWithAppIcon extends StatelessWidget {
  final bool isLoading;
  final EdgeInsetsGeometry? paddingSpacingLogo;
  final EdgeInsetsGeometry? paddingSpacingProgress;

  final Widget child;
  final Widget appIcon;
  final double appIconSize;
  final double borderRadius;
  final double overlayOpacity;
  final Color? overlayBackgroundColor;
  final Color? circularProgressColor;
  final double? strokeWidth;
  const LoadingWithAppIcon(
      {super.key,
      required this.isLoading,
      required this.child,
      this.paddingSpacingLogo,
      this.paddingSpacingProgress,
      required this.appIcon,
      this.strokeWidth,
      this.appIconSize = 40,
      this.borderRadius = 16,
      this.overlayOpacity = 0.6,
      this.circularProgressColor,
      this.overlayBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return OverLayAnimation(
      isLoading: isLoading,
      opacity: overlayOpacity,
      color: overlayBackgroundColor ?? Theme.of(context).colorScheme.background,
      progressIndicator: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: paddingSpacingProgress ?? EdgeInsets.all(12.r),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: CircularProgressIndicator(
                  color: circularProgressColor ??
                      Theme.of(context).colorScheme.background,
                  strokeWidth: strokeWidth ?? 0.6,
                ),
              ),
              Padding(
                padding: paddingSpacingLogo ?? EdgeInsets.all(6.r),
                child: SizedBox(
                  width: appIconSize,
                  height: appIconSize,
                  child: appIcon,
                ),
              ),
            ],
          ),
        ),
      ), //Change this loading overlay
      child: child,
    );
  }
}

//OverLayAnimation class for ModalBarrier
class OverLayAnimation extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  final Color? color;
  final Widget progressIndicator;
  final Widget child;

  const OverLayAnimation({
    super.key,
    required this.isLoading,
    required this.child,
    this.opacity = 0.5,
    this.progressIndicator = const CircularProgressIndicator(),
    this.color,
  });

  @override
  State<OverLayAnimation> createState() => _OverLayAnimationState();
}

class _OverLayAnimationState extends State<OverLayAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  _OverLayAnimationState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      status == AnimationStatus.forward
          ? setState(() => {_overlayVisible = true})
          : null;
      status == AnimationStatus.dismissed
          ? setState(() => {_overlayVisible = false})
          : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(OverLayAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: widget.opacity,
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Theme.of(context).colorScheme.background,
              ),
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}
