import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';

enum AppSolidButtonRadius { rounded, circle }

class AppSolidButton extends StatelessWidget {
  const AppSolidButton._({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHighlightChanged,
    this.mouseCursor,
    this.textTheme,
    this.textColor = colorWhite,
    this.disabledTextColor = colorWhite,
    this.color,
    this.disabledColor,
    this.splashColor = colorPrimary,
    this.focusColor = colorPrimary,
    this.hoverColor = colorPrimary,
    this.highlightColor = colorPrimary,
    this.colorBrightness,
    this.elevation = _defaultElevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding = _defaultPadding,
    this.visualDensity,
    this.shape = _defaultShape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.animationDuration,
    this.minWidth,
    this.height,
    this.enableFeedback = true,
    this.child,
  });

  factory AppSolidButton.small(
    String text, {
    Widget? leading,
    AppSolidButtonRadius radiusType = AppSolidButtonRadius.circle,
    Widget? rear,
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    FocusNode? focusNode,
    bool autofocus = false,
    Duration? animationDuration,
    Color? color,
    Color? disabledColor,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minWidth,
    double? minHeight,
    bool enableFeedback = true,
  }) {
    double radius;
    if (radiusType == AppSolidButtonRadius.circle) {
      radius = 16;
    } else {
      radius = 8;
    }
    return AppSolidButton._(
      key: key,
      onPressed: onPressed,
      color: color,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      focusNode: focusNode,
      autofocus: autofocus,
      disabledColor: disabledColor,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth ?? 100,
      height: minHeight ?? 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      enableFeedback: enableFeedback,
      child: _defaultContent(
        text,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        leading: leading,
        rear: rear,
      ),
    );
  }

  factory AppSolidButton.medium(
    String text, {
    Widget? leading,
    AppSolidButtonRadius radiusType = AppSolidButtonRadius.circle,
    Widget? rear,
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    MouseCursor? mouseCursor,
    ButtonTextTheme? textTheme,
    FocusNode? focusNode,
    bool autofocus = false,
    Duration? animationDuration,
    Color? color,
    Color? disabledColor,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minWidth,
    bool enableFeedback = true,
    TextStyle? textStyle,
  }) {
    double radius;
    if (radiusType == AppSolidButtonRadius.circle) {
      radius = 16;
    } else {
      radius = 12;
    }
    return AppSolidButton._(
      key: key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      color: color,
      disabledColor: disabledColor,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      textTheme: textTheme,
      focusNode: focusNode,
      padding: const EdgeInsets.all(6),
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth,
      height: 40,
      enableFeedback: enableFeedback,
      child: _defaultContent(
        text,
        textStyle: textStyle ??
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
        leading: leading,
        rear: rear,
      ),
    );
  }

  // factory
  static Widget _defaultLabel(String text, TextStyle textStyle) => Text(
        text,
        style: textStyle,
        maxLines: 2,
        textAlign: TextAlign.center,
      );
  static Widget _defaultContent(
    String text, {
    required TextStyle textStyle,
    Widget? leading,
    Widget? rear,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        leading ?? space0,
        () {
          if (leading != null) {
            return spaceW4;
          } else {
            return space0;
          }
        }(),
        Expanded(child: _defaultLabel(text, textStyle)),
        () {
          if (rear != null) {
            return spaceW4;
          } else {
            return space0;
          }
        }(),
        rear ?? space0,
      ],
    );
  }

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHighlightChanged;
  final MouseCursor? mouseCursor;
  final ButtonTextTheme? textTheme;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? color;
  final Color? disabledColor;
  final Color? splashColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final double? elevation;
  final double? hoverElevation;
  final double? focusElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final Brightness? colorBrightness;
  final Widget? child;

  bool get enabled => onPressed != null || onLongPress != null;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration? animationDuration;
  final MaterialTapTargetSize? materialTapTargetSize;
  final double? minWidth;
  final double? height;

  final bool enableFeedback;

  @override
  Widget build(BuildContext context) {
    final primarColor = color ?? context.theme.primaryColor;
    return MaterialButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: enabled ? primarColor : primarColor.withOpacity(0.5),
      disabledColor:
          disabledColor ?? context.theme.primaryColor.withOpacity(0.5),
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      elevation: elevation,
      focusElevation: focusElevation,
      hoverElevation: hoverElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: padding,
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth,
      height: height,
      enableFeedback: enableFeedback,
      child: child,
    );
  }

  static const EdgeInsetsGeometry _defaultPadding = EdgeInsets.all(8);

  static const RoundedRectangleBorder _defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static const double _defaultElevation = 0;
}
