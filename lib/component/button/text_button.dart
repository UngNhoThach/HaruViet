import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatefulWidget {
  const AppTextButton._({
    super.key,
    required this.onPressed,
    this.textStyle,
    this.onLongPress,
    this.onHighlightChanged,
    this.mouseCursor,
    this.textTheme,
    this.textColor = colorPrimary,
    this.disabledTextColor = colorPrimary,
    this.color = Colors.transparent,
    this.disabledColor = colorPrimary,
    this.splashColor = Colors.transparent,
    this.focusColor = colorPrimary,
    this.hoverColor = Colors.transparent,
    this.highlightColor = Colors.transparent,
    this.colorBrightness,
    this.elevation = _defaultElevation,
    this.focusElevation = 0,
    this.hoverElevation = 0,
    this.highlightElevation = 0,
    this.disabledElevation = 0,
    this.padding = _defaultPadding,
    this.visualDensity,
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

  factory AppTextButton.small(
    String text, {
    TextStyle? textStyle,
    Widget? leading,
    Widget? rear,
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    FocusNode? focusNode,
    bool autofocus = false,
    Duration? animationDuration,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minWidth,
    bool enableFeedback = true,
    EdgeInsetsGeometry? padding,
  }) {
    return AppTextButton._(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth,
      height: 40,
      padding: padding ?? const EdgeInsets.fromLTRB(12, 8, 12, 8),
      enableFeedback: enableFeedback,
      child: _defaultContent(
        text,
        textStyle: textStyle ??
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
        leading: leading,
        rear: rear,
      ),
    );
  }

  factory AppTextButton.medium(
    String text, {
    Key? key,
    TextStyle? textStyle,
    Widget? leading,
    Widget? rear,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    bool autofocus = false,
    Duration? animationDuration,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minWidth,
    bool enableFeedback = true,
  }) {
    return AppTextButton._(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      padding: const EdgeInsets.all(12),
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth,
      height: 48,
      enableFeedback: enableFeedback,
      child: _defaultContent(
        text,
        textStyle: textStyle ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1,
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
            return spaceW12;
          } else {
            return space0;
          }
        }(),
        _defaultLabel(text, textStyle),
        () {
          if (rear != null) {
            return spaceW8;
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
  final Color disabledTextColor;
  final Color color;
  final Color disabledColor;
  final Color splashColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final double? elevation;
  final double? hoverElevation;
  final double? focusElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final Brightness? colorBrightness;
  final TextStyle? textStyle;
  final Widget? child;

  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration? animationDuration;
  final MaterialTapTargetSize? materialTapTargetSize;
  final double? minWidth;
  final double? height;

  final bool enableFeedback;

  @override
  State<AppTextButton> createState() => _AppTextButtonState();

  static const EdgeInsetsGeometry _defaultPadding = EdgeInsets.all(8);
  static const double _defaultElevation = 0;
}

class _AppTextButtonState extends State<AppTextButton> {
  bool get enabled => widget.onPressed != null || widget.onLongPress != null;
  var _isFocus = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        setState(() {
          _isFocus = true;
        });
      },
      onTapUp: (detail) {
        setState(() {
          _isFocus = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isFocus = false;
        });
      },
      child: MaterialButton(
        onPressed: widget.onPressed,
        onLongPress: widget.onLongPress,
        onHighlightChanged: widget.onHighlightChanged,
        mouseCursor: widget.mouseCursor,
        textTheme: widget.textTheme,
        textColor: _isFocus ? widget.focusColor : widget.textColor,
        disabledTextColor: widget.disabledTextColor,
        color: Colors.transparent,
        disabledColor: Colors.transparent,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
        highlightColor: widget.highlightColor,
        splashColor: widget.splashColor,
        colorBrightness: widget.colorBrightness,
        elevation: widget.elevation,
        focusElevation: widget.focusElevation,
        hoverElevation: widget.hoverElevation,
        highlightElevation: widget.highlightElevation,
        disabledElevation: widget.disabledElevation,
        padding: widget.padding,
        visualDensity: widget.visualDensity,
        clipBehavior: widget.clipBehavior,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        materialTapTargetSize: widget.materialTapTargetSize,
        animationDuration: widget.animationDuration,
        minWidth: widget.minWidth,
        height: widget.height,
        enableFeedback: widget.enableFeedback,
        child: widget.child,
      ),
    );
  }
}
