import 'package:flutter/material.dart';
import 'package:haruviet/component/dropdown/dropdown_item_row.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/theme/typography.dart';

class DropDownOptionProducts extends StatelessWidget {
  const DropDownOptionProducts({
    super.key,
    this.initValue,
    required this.onChanged,
    this.border,
    required this.reasonList,
    required this.label,
    this.isRequiredLabel = false,
    this.isDense = false,
  });

  final ValueOptionProduct? initValue;
  final void Function(ValueOptionProduct? value) onChanged;
  final InputBorder? border;
  final List<ValueOptionProduct> reasonList;
  final String label;
  final bool isRequiredLabel;
  final bool isDense;
  // final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AppDropDownFormFieldRow<ValueOptionProduct>(
      border: border,
      value: initValue,
      isExpanded: true,
      isDense: isDense,
      label: isRequiredLabel ? null : label,
      requiredLabel: isRequiredLabel ? label : null,
      items: reasonList
          .map(
            (e) => DropdownMenuItem<ValueOptionProduct>(
              value: e,
              child: Text(
                e.title ?? "",
                style: textTheme.bodySmall?.copyWith(
                  color: context.appColorScheme.colorExtendedTextBodySmall,
                ),
              ),
            ),
          )
          .toList(),
      onSelect: (value) {
        onChanged(value);
      },
    );
  }
}
