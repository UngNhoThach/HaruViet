import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/gen/assets.gen.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterProductList extends StatelessWidget {
  const FilterProductList(
      {super.key,
      required this.statusSelected,
      required this.onSelect,
      required this.checkIsChangeListItem,
      required this.onChangeListItem,
      required this.onTapFilter,
      this.widgetPrice});

  final CurrentTab statusSelected;
  final void Function(CurrentTab) onSelect;
  final bool checkIsChangeListItem;
  final Function() onTapFilter;
  final void Function() onChangeListItem;
  final Widget? widgetPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: colorWhite,
          border: Border(
            bottom: BorderSide(color: colorGray03, width: 5),
            //    top: BorderSide(color: colorGray03, width: 5)
          ),
          boxShadow: [
            BoxShadow(
              color: colorGray03,
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      height: 38.h,
      child: Row(
        children: [
          spaceW6,
          Expanded(
            flex: 7, // Takes up 6 parts of the space
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              itemBuilder: (context, index) {
                final e = CurrentTab.values[index];

                // Check if e is an empty string
                if (e.name.isEmpty || e.name == '') {
                  return const SizedBox.shrink(); // Return an empty widget
                }

                return SizedBox(
                  width:
                      83.w, // Set equal width for each item (adjust as needed)
                  child: FilterChip(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          e.name,
                          style: textTheme.bodyMedium?.copyWith(
                            color: statusSelected == e ? colorMain : colorBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (e != CurrentTab.latest &&
                            e != CurrentTab.topsale) ...[
                          const SizedBox(
                              width: 2), // Spacing between text and icon
                          Image.asset(
                            Assets.icons.filterHotDeal.path,
                            fit: BoxFit.fill,
                          )
                        ]
                      ],
                    ),
                    selected: statusSelected == e,
                    onSelected: (bool selected) {
                      if (selected) {
                        onSelect(e);
                      }
                    },
                    selectedColor: colorWhite,
                    backgroundColor: colorWhite,
                    showCheckmark: false,
                  ),
                );
              },
              itemCount:
                  CurrentTab.values.where((e) => e.name.isNotEmpty).length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 2,
              ), // Add a line between items
            ),
          ),
          Expanded(
            flex: 2, // Chiếm 2 phần không gian
            child: Center(
              child: widgetPrice,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  EdgeInsets.only(right: 8.w), // Tạo khoảng cách với cạnh phải
              child: IconButton(
                onPressed: onChangeListItem,
                icon: Icon(
                  checkIsChangeListItem
                      ? Icons.border_all
                      : Icons.format_line_spacing_outlined,
                  color: colorBlack,
                  size:
                      24, // Kích thước nhỏ hơn một chút để chiếm ít diện tích hơn
                ),
              ),
            ),
          ),
          spaceW12,
        ],
      ),
    );
  }
}
