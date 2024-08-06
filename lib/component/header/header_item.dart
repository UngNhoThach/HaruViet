import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterProductList extends StatelessWidget {
  const FilterProductList({
    super.key,
    required this.statusSelected,
    required this.onSelect,
  });

  final CurrentTab statusSelected;
  final void Function(CurrentTab) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        itemBuilder: (context, index) {
          final e = CurrentTab.values[index];
          return FilterChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              6.r,
            )),
            label: Text(
              e.name,
              style: textTheme.bodyMedium?.copyWith(
                color: statusSelected == e ? e.color : const Color(0xFF747474),
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: statusSelected == e,
            onSelected: (bool selected) {
              if (selected) {
                onSelect(e);
              }
            },
            selectedColor: e.backgroundColor,
            backgroundColor: colorWhite,
            showCheckmark: false,
          );
        },
        itemCount: CurrentTab.values.length,
        separatorBuilder: (context, index) => spaceW16,
      ),
    );
  }
}
