// import 'package:flutter/material.dart';

// enum AppOutlineButtonRadius { rounded, circle }

// class AppOutlineButton extends StatefulWidget {
//   const AppOutlineButton._({
//     super.key,
//     required this.onPressed,
//     this.onLongPress,
//     this.onHighlightChanged,
//     this.mouseCursor,
//     this.textTheme,
//     this.textColor,
//     this.disabledTextColor,
//     this.color,
//     this.disabledColor,
//     this.splashColor = Colors.transparent,
//     this.focusColor,
//     this.hoverColor = Colors.transparent,
//     this.highlightColor = Colors.transparent,
//     this.colorBrightness,
//     this.isChangeColorBr = false,
//     this.elevation = _defaultElevation,
//     this.focusElevation = 0,
//     this.hoverElevation = 0,
//     this.highlightElevation = 0,
//     this.disabledElevation = 0,
//     this.padding = _defaultPadding,
//     this.visualDensity,
//     this.radius,
//     this.clipBehavior = Clip.none,
//     this.focusNode,
//     this.autofocus = false,
//     this.materialTapTargetSize,
//     this.animationDuration,
//     this.minWidth,
//     this.height,
//     this.enableFeedback = true,
//     this.child,
//   });

//   factory AppOutlineButton.small(
//     String text, {
//     Widget? leading,
//     AppOutlineButtonRadius radiusType = AppOutlineButtonRadius.circle,
//     Widget? rear,
//     Key? key,
//     required VoidCallback? onPressed,
//     VoidCallback? onLongPress,
//     ValueChanged<bool>? onHighlightChanged,
//     FocusNode? focusNode,
//     bool autofocus = false,
//     Duration? animationDuration,
//     Color? color,
//     Color? disabledTextColor,
//     Color? disabledColor,
//     Color? focusColor,
//     MaterialTapTargetSize? materialTapTargetSize,
//     double? minWidth,
//     bool enableFeedback = true,
//     EdgeInsetsGeometry? padding,
//     double? height,
//   }) {
//     double radius;
//     if (radiusType == AppOutlineButtonRadius.circle) {
//       radius = 20;
//     } else {
//       radius = 8;
//     }
//     return AppOutlineButton._(
//       key: key,
//       onPressed: onPressed,
//       onLongPress: onLongPress,
//       color: color,
//       textColor: color,
//       disabledTextColor: disabledTextColor,
//       disabledColor: disabledColor,
//       focusColor: focusColor,
//       onHighlightChanged: onHighlightChanged,
//       focusNode: focusNode,
//       autofocus: autofocus,
//       materialTapTargetSize: materialTapTargetSize,
//       animationDuration: animationDuration,
//       minWidth: minWidth,
//       height: height ?? 40,
//       radius: radius,
//       padding: padding ?? const EdgeInsets.fromLTRB(12, 4, 12, 4),
//       enableFeedback: enableFeedback,
//       child: _defaultContent(
//         text,
//         textStyle: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//         ),
//         leading: leading,
//         rear: rear,
//       ),
//     );
//   }

//   factory AppOutlineButton.medium(
//     String text, {
//     Key? key,
//     Widget? leading,
//     AppOutlineButtonRadius radiusType = AppOutlineButtonRadius.circle,
//     Widget? rear,
//     required VoidCallback? onPressed,
//     VoidCallback? onLongPress,
//     ValueChanged<bool>? onHighlightChanged,
//     MouseCursor? mouseCursor,
//     FocusNode? focusNode,
//     bool autofocus = false,
//     Duration? animationDuration,
//     MaterialTapTargetSize? materialTapTargetSize,
//     double? minWidth,
//     bool enableFeedback = true,
//     Color? color,
//   }) {
//     double radius;
//     if (radiusType == AppOutlineButtonRadius.circle) {
//       radius = 24;
//     } else {
//       radius = 16;
//     }
//     return AppOutlineButton._(
//       key: key,
//       color: color,
//       textColor: color,
//       radius: radius,
//       onPressed: onPressed,
//       onLongPress: onLongPress,
//       onHighlightChanged: onHighlightChanged,
//       mouseCursor: mouseCursor,
//       focusNode: focusNode,
//       padding: const EdgeInsets.all(12),
//       autofocus: autofocus,
//       materialTapTargetSize: materialTapTargetSize,
//       animationDuration: animationDuration,
//       minWidth: minWidth,
//       height: 48,
//       enableFeedback: enableFeedback,
//       child: _defaultContent(
//         text,
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//           height: 24 / 16,
//         ),
//         leading: leading,
//         rear: rear,
//       ),
//     );
//   }

//   // factory
//   static Widget _defaultLabel(String text, TextStyle textStyle) => Text(
//         text,
//         style: textStyle,
//       );

//   static Widget _defaultContent(
//     String text, {
//     required TextStyle textStyle,
//     Widget? leading,
//     Widget? rear,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         leading ?? space0,
//         () {
//           if (leading != null) {
//             return spaceW12;
//           } else {
//             return space0;
//           }
//         }(),
//         _defaultLabel(text, textStyle),
//         () {
//           if (rear != null) {
//             return spaceW12;
//           } else {
//             return space0;
//           }
//         }(),
//         rear ?? space0,
//       ],
//     );
//   }

//   final VoidCallback? onPressed;
//   final VoidCallback? onLongPress;
//   final ValueChanged<bool>? onHighlightChanged;
//   final MouseCursor? mouseCursor;
//   final ButtonTextTheme? textTheme;
//   final Color? textColor;
//   final Color? disabledTextColor;
//   final Color? color;
//   final Color? disabledColor;
//   final Color splashColor;
//   final Color? focusColor;
//   final Color hoverColor;
//   final Color highlightColor;
//   final double? elevation;
//   final double? hoverElevation;
//   final double? focusElevation;
//   final double? highlightElevation;
//   final double? disabledElevation;
//   final Brightness? colorBrightness;
//   final bool isChangeColorBr;
//   final Widget? child;

//   final EdgeInsetsGeometry? padding;
//   final VisualDensity? visualDensity;
//   final double? radius;
//   final Clip clipBehavior;
//   final FocusNode? focusNode;
//   final bool autofocus;
//   final Duration? animationDuration;
//   final MaterialTapTargetSize? materialTapTargetSize;
//   final double? minWidth;
//   final double? height;

//   final bool enableFeedback;

//   @override
//   State<AppOutlineButton> createState() => _AppOutlineButtonState();

//   static const EdgeInsetsGeometry _defaultPadding = EdgeInsets.all(8);
//   static const double _defaultElevation = 0;
// }

// class _AppOutlineButtonState extends State<AppOutlineButton> {
//   bool get enabled => widget.onPressed != null || widget.onLongPress != null;
//   var _isFocus = false;

//   @override
//   Widget build(BuildContext context) {
//     final textColor = widget.textColor ?? context.theme.primaryColor;
//     return GestureDetector(
//       onTapDown: (detail) {
//         setState(() {
//           _isFocus = true;
//         });
//       },
//       onTapUp: (detail) {
//         setState(() {
//           _isFocus = false;
//         });
//       },
//       onTapCancel: () {
//         setState(() {
//           _isFocus = false;
//         });
//       },
//       child: MaterialButton(
//         onPressed: widget.onPressed,
//         onLongPress: widget.onLongPress,
//         onHighlightChanged: widget.onHighlightChanged,
//         mouseCursor: widget.mouseCursor,
//         textTheme: widget.textTheme,
//         textColor: enabled ? textColor : textColor.withOpacity(0.5),
//         // ? widget.focusColor
//         // : enabled ? widget.textColor ?? context.theme.primaryColor,
//         disabledTextColor:
//             (widget.disabledTextColor ?? context.theme.primaryColor)
//                 .withOpacity(0.5),
//         color: widget.isChangeColorBr ? widget.color : Colors.transparent,
//         disabledColor: Colors.transparent,
//         focusColor: widget.focusColor,
//         hoverColor: widget.hoverColor,
//         highlightColor: widget.highlightColor,
//         splashColor: widget.splashColor,
//         colorBrightness: widget.colorBrightness,
//         elevation: widget.elevation,
//         focusElevation: widget.focusElevation,
//         hoverElevation: widget.hoverElevation,
//         highlightElevation: widget.highlightElevation,
//         disabledElevation: widget.disabledElevation,
//         padding: widget.padding,
//         visualDensity: widget.visualDensity,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(
//             color: enabled
//                 ? (_isFocus
//                     ? (widget.focusColor ?? context.theme.primaryColor)
//                     : (widget.color ?? context.theme.primaryColor))
//                 : widget.disabledColor ??
//                     context.theme.primaryColor.withOpacity(0.5),
//           ),
//           borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0)),
//         ),
//         clipBehavior: widget.clipBehavior,
//         focusNode: widget.focusNode,
//         autofocus: widget.autofocus,
//         materialTapTargetSize: widget.materialTapTargetSize,
//         animationDuration: widget.animationDuration,
//         minWidth: widget.minWidth,
//         height: widget.height,
//         enableFeedback: widget.enableFeedback,
//         child: widget.child,
//       ),
//     );
//   }
// }
