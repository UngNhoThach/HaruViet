import 'package:eco_app/component/status/status_header_item.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterProductList extends StatelessWidget {
  const FilterProductList({
    super.key,
    required this.statusSelected,
    required this.onSelect,
  });

  final int statusSelected;
  final void Function() onSelect;

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
          final e = StatusWork.values[index];
          return FilterChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              6.r,
            )),
            label: Text(
              e.name,
              style: textTheme.bodyMedium?.copyWith(
                color: statusSelected == e.index
                    ? e.color
                    : const Color(0xFF747474),
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: statusSelected == e.index,
            onSelected: (bool selected) {
              if (selected) {
                onSelect();
              }
            },
            selectedColor: e.backgroundColor,
            backgroundColor: colorWhite,
            showCheckmark: false,
          );
        },
        itemCount: StatusWork.values.length,
        separatorBuilder: (context, index) => spaceW16,
      ),
    );
  }
}
