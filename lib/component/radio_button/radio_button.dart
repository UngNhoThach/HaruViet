import 'package:haruviet/data/reponsitory/shipment/payment_response/data_payment.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioListSelect extends StatelessWidget {
  const RadioListSelect({
    super.key,
    required this.itemsTypeDataPayment,
    required this.itemsTypeString,
    required this.onSelectedIndex,
    this.currentIndex,
    this.isVertical = false,
    this.enabled = true,
  });
  final List<DataPayment> itemsTypeDataPayment;
  final List<String> itemsTypeString;
  final int? currentIndex;
  final ValueChanged<int?> onSelectedIndex;
  final bool isVertical;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final childrens = <Widget>[];
    // use 2 types of data itemsTypeString or itemsTypeDataPayment
    itemsTypeString.isEmpty
        ? itemsTypeDataPayment.asMap().forEach((key, value) {
            childrens.add(isVertical
                ? Expanded(child: _radioButton(context, key, value.title ?? ''))
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: _radioButton(context, key, value.title ?? ''),
                  ));
          })
        : itemsTypeString.asMap().forEach((key, value) {
            childrens.add(isVertical
                ? Expanded(child: _radioButton(context, key, value))
                : _radioButton(context, key, value));
          });
    return isVertical ? Row(children: childrens) : Column(children: childrens);
  }

  Widget _radioButton(BuildContext context, int index, String title) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: enabled
          ? () {
              onSelectedIndex(index);
            }
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: isSelected ? 6.w : 1.w,
                    color: isSelected && enabled ? colorBlue : colorGrey,
                  ),
                ),
              ),
            ),
            spaceW12,
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  overflow: TextOverflow.clip,
                  color: context.appColorScheme.colorExtendedTextBodyMedium,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
