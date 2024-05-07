import 'package:eco_app/component/header/widgets/list_category.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterCategoryList extends StatelessWidget {
  const FilterCategoryList({
    super.key,
    required this.statusSelected,
    required this.onSelect,
  });

  final int statusSelected;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        itemBuilder: (context, index) {
          final e = CategoryList.values[index];
          return GestureDetector(
            onTap: () {
              onSelect();
            },
            child: Container(
              width: 70.w,
              decoration: BoxDecoration(
                  color: statusSelected == e.index
                      ? e.backgroundColor
                      : colorWhite,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: statusSelected == e.index
                        ? e.backgroundColor
                        : colorBlueGray02,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Image.network(
                      'https://maybomhoachat.vn/sites/default/files/dien-ap.jpg',
                      width: 40.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      e.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: statusSelected == e.index
                            ? colorWhite
                            : const Color(0xFF747474),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: CategoryList.values.length,
        separatorBuilder: (context, index) => spaceW16,
      ),
    );
  }
}
