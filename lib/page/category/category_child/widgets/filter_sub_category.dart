import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';

class FilterSubCategory extends StatefulWidget {
  const FilterSubCategory({
    super.key,
    required this.onTap,
    this.isFilter = false,
    this.nameCategory,
    this.widget,
    required this.onTapFilter,
  });

  final void Function() onTap;
  final String? nameCategory;
  final bool isFilter;
  final Widget? widget;
  final void Function() onTapFilter;
  @override
  State<FilterSubCategory> createState() => _FilterSubCategoryState();
}

class _FilterSubCategoryState extends State<FilterSubCategory> {
  // variables and functiions

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
          color: colorWhite,
          border: Border(
            bottom: BorderSide(color: colorGray02, width: 4),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        widget.nameCategory ?? '',
                        style: textTheme.bodyMedium?.copyWith(
                            color: context
                                .appColorScheme.colorExtendedTextBodyMedium,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              widget.isFilter
                  ? Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: widget.onTapFilter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Lọc',
                              style: textTheme.bodyMedium?.copyWith(
                                  color: colorBlack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            const Icon(
                              Icons.filter_alt_sharp,
                              color: colorError03,
                            ),
                          ],
                        ),
                      ),
                    )
                  : space0,
            ],
          ),
          widget.widget ?? space0,
        ],
      ),
    );
  }
}
