import 'package:flutter/material.dart';
import 'package:haruviet/component/dropdown/dropdown_item_row.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/theme/typography.dart';

class DropDownOptionProducts extends StatelessWidget {
  const DropDownOptionProducts({
    super.key,
    this.initValue,
    required this.onChanged,
    this.border,
    required this.item,
    required this.label,
    this.isRequiredLabel = false,
    this.isDense = false,
  });

  final ValueOptionProduct? initValue;
  final void Function(ValueOptionProduct? value) onChanged;
  final InputBorder? border;
  final Option item;
  final String label;
  final bool isRequiredLabel;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    // Tìm giá trị nào có isSelected == true
    final ValueOptionProduct? selectedValue;
    final check = item.values!.any((element) => element.isSelected == true);

    selectedValue = item.values!.firstWhere(
      (e) => e.isSelected,
      orElse: () => item.values![0],
    );

    return AppDropDownFormFieldRow<ValueOptionProduct>(
      border: border,
      value: check == true ? selectedValue : initValue,
      isExpanded: true,
      isDense: isDense,
      label: isRequiredLabel ? null : label,
      requiredLabel: isRequiredLabel ? label : null,
      items: item.values!
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
