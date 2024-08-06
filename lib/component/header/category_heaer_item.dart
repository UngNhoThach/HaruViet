import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_category.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryHeaderIteam extends StatelessWidget {
  const CategoryHeaderIteam({
    super.key,
    required this.searchCategory,
    required this.onSelect,
  });

  final SearchCategory searchCategory;
  final void Function(CurrentTab) onSelect;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
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
                color: searchCategory == e ? e.color : const Color(0xFF747474),
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: searchCategory == e,
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
