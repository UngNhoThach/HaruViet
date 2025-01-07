import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/get_cart_order_response/get_cart_order_response.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/count_qualition.dart';
import 'package:haruviet/theme/typography.dart';

class CartListItem extends StatefulWidget {
  const CartListItem(
      {Key? key,
      required this.item,
      required this.onPressedDelete,
      required this.onDismissed,
      required this.onCounterChanged,
      required this.domain,
      required this.index,
      required this.quantityNotifier})
      : super(key: key);

  final GetCartOrderResponse item;
  final ValueChanged<int> onCounterChanged;
  final int index;
  final String domain;
  final void Function() onDismissed;
  final void Function(BuildContext)? onPressedDelete;
  final ValueNotifier<int> quantityNotifier;

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  late ValueNotifier<int> quantityNotifier;

  @override
  void initState() {
    super.initState();
    quantityNotifier = ValueNotifier<int>(widget.item.qty ?? 0);
  }

  @override
  void dispose() {
    quantityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color colorPrimaryCover = Theme.of(context).primaryColorLight;
    final item = widget.item;

    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          resizeDuration: const Duration(microseconds: 500),
          dismissThreshold: 0.6,
          onDismissed: widget.onDismissed,
        ),
        children: [
          SlidableAction(
            spacing: 2,
            onPressed: widget.onPressedDelete,
            backgroundColor: colorMain,
            foregroundColor: colorWhite,
            icon: Icons.delete,
            label: 'Xoá',
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Ảnh sản phẩm
                Container(
                  margin: EdgeInsets.all(8.r),
                  width: 60.w,
                  height: 60.h,
                  child: CachedNetworkImage(
                    fadeOutDuration: const Duration(seconds: 3),
                    imageUrl: '${widget.domain}${item.image ?? ''}',
                    width: 60.w,
                    // placeholder: (context, url) => ImageProductShimer(
                    //   width: 60.w,
                    //   height: 60.h,
                    // ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8.w, top: 4.h),
                          child: Text(
                            item.name ?? '',
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                                color: colorBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        spaceH12,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              defaultCurrencyVNDFormatter.formatString(
                                (item.price.toString()),
                              ),
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorSuccess03,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: ValueListenableBuilder<int>(
                                valueListenable: quantityNotifier,
                                builder: (context, qty, _) {
                                  return CountQuality(
                                    initialCounter: qty,
                                    onCounterChanged: (newCounter) {
                                      quantityNotifier.value = newCounter;
                                      widget.onCounterChanged(newCounter);
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        // if (item.attributes?.promotions != null &&
                        //     item.attributes!.promotions!.isNotEmpty) ...[
                        //   const Divider(),
                        //   Text(
                        //     '${item.attributes?.promotions?[0]}',
                        //     style: textTheme.bodyMedium?.copyWith(
                        //       color: colorPrimaryCover,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //   ),
                        //   spaceH6,
                        // ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
            spaceH6,
            if (item.gift != null) ...[
              // Hiển thị quà tặng nếu có
            ]
          ],
        ),
      ),
    );
  }
}
