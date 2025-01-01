import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';

class WidgetProductOneRowNotLoading extends StatelessWidget {
  final double? height;
  final Widget Function(BuildContext, DataProduct, int) itemBuilder;
  final EdgeInsets padding;
  final Color? gradientColor;
  final Axis scrollDirection;
  final ScrollPhysics physics;
  final List<DataProduct>? items; // Optional direct list of items
  final Color? backroundColor;
  const WidgetProductOneRowNotLoading({
    Key? key,
    this.height,
    this.backroundColor,
    required this.items,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.gradientColor, // Default color; customize as needed
    this.scrollDirection = Axis.horizontal,
    this.physics = const ClampingScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 260.h,
      decoration: BoxDecoration(
        color: backroundColor,
        gradient: gradientColor != null
            ? LinearGradient(
                colors: [gradientColor!, gradientColor!.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
      ),
      child: ListView.separated(
        padding: padding,
        scrollDirection: scrollDirection,
        physics: physics,
        itemCount: items?.length ?? 0,
        itemBuilder: (context, index) {
          final item = items![index];
          return itemBuilder(context, item, index);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 12),
      ),
    );
  }
}
