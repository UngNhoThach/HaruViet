import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WidgetProductOneRowLoading extends StatelessWidget {
  final double? height;
  final PagingController<int, DataProduct> pagingController;
  final Widget Function(BuildContext, DataProduct, int) itemBuilder;
  final Widget Function(BuildContext)? noItemsFoundIndicatorBuilder;
  final EdgeInsets padding;
  final Color gradientColor;
  final Axis scrollDirection;
  final ScrollPhysics physics;

  const WidgetProductOneRowLoading({
    Key? key,
    this.height,
    required this.pagingController,
    required this.itemBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.gradientColor = Colors.blue, // Default color; customize as needed
    this.scrollDirection = Axis.horizontal,
    this.physics = const ClampingScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 260.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment(0.0, 0.6),
          begin: Alignment(0.0, -1),
          colors: <Color>[colorMainCover, colorWhite],
        ),
      ),
      child: PagedListView.separated(
        padding: padding,
        scrollDirection: scrollDirection,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        pagingController: pagingController,
        physics: physics,
        builderDelegate: PagedChildBuilderDelegate<DataProduct>(
          noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
          itemBuilder: itemBuilder,
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
      ),
    );
  }
}
