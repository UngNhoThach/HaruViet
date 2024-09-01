import 'package:flutter/material.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/theme/typography.dart';

class AppDropDownFormFieldRow<T> extends StatelessWidget {
  const AppDropDownFormFieldRow({
    super.key,
    required this.value,
    required this.items,
    required this.onSelect,
    this.icon,
    this.isRequired = false,
    this.label,
    this.requiredLabel,
    this.isExpanded = false,
    this.helperText,
    this.prefixIcon,
    this.padding,
    this.border,
    this.isDense = true,
    this.textStyle,
    this.alignment,
  });

  final T? value;
  final bool isExpanded;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onSelect;
  final bool isRequired;
  final String? label;
  final String? requiredLabel;
  final String? helperText;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final InputBorder? border;
  final bool isDense;
  final AlignmentGeometry? alignment;

  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: DropdownButtonFormField<T>(
        alignment: alignment ?? Alignment.centerLeft,
        style: textStyle ?? textTheme.bodyMedium,
        isExpanded: isExpanded,
        isDense: isDense,
        icon: icon ?? const Icon(Icons.keyboard_arrow_down_outlined),
        items: items,
        value: value,
        itemHeight: 50,
        onChanged: onSelect,
        menuMaxHeight: 500,
        decoration: InputDecoration(
          border: border,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          enabledBorder: border,
          focusedBorder: border,
          prefixIcon: prefixIcon,
          helperText: helperText,
          helperStyle: TextStyle(
            color: context.appColor.colorOrange,
          ),
          labelStyle: textTheme.bodySmall,
          labelText: label,
        ),
      ),
    );
  }
}
