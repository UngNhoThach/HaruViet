import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/get_cart_order_response/get_cart_order_response.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';

class ProductListWidgetViewMore extends StatefulWidget {
  final List<GetCartOrderResponse> productList;
  final TextStyle styleSubPrice;
  final String domain;
  final TextStyle styleSubTitle;
  const ProductListWidgetViewMore({
    Key? key,
    required this.styleSubPrice,
    required this.domain,
    required this.styleSubTitle,
    required this.productList,
  }) : super(key: key);

  @override
  _ProductListWidgetViewMoreState createState() =>
      _ProductListWidgetViewMoreState();
}

class _ProductListWidgetViewMoreState extends State<ProductListWidgetViewMore> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final displayedList =
        _showAll ? widget.productList : widget.productList.take(3).toList();

    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          ...List.generate(displayedList.length * 2 - 1, (index) {
            if (!index.isEven) {
              return Container(
                color: colorGray02,
                height: 1,
                width: double.infinity,
                child: const SizedBox(),
              );
            } else {
              return _itemProductRender(context,
                  domain: widget.domain,
                  styleSubPrice: widget.styleSubPrice,
                  styleSubTitle: widget.styleSubTitle,
                  item: displayedList[index ~/ 2]);
            }
          }),
          if (widget.productList.length > 3)
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20), // Padding top và bottom
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showAll = !_showAll;
                  });
                },
                child: Text(
                  _showAll ? 'Thu gọn' : 'Xem tất cả',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _itemProductRender(BuildContext context,
      {required GetCartOrderResponse item,
      required TextStyle styleSubPrice,
      required String domain,
      required TextStyle styleSubTitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      height: 82.h,
      width: double.infinity,
      child: Column(children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: double.infinity,
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 56.w,
                  height: 56.h,
                  child: Image.network(
                    '$domain${item.image}',
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  item.name ?? '',
                                  //     item.     descriptions.name ?? '',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            Text("Số lượng: ${item.qty}", style: styleSubTitle),
                            spaceH4,
                            Text(
                                defaultCurrencyVNDFormatter
                                    .formatString(item.price.toString()),
                                style: styleSubTitle),
                          ]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(defaultCurrencyVNDFormatter.formatString(
                                //   (item.price.price! * item.totalQuantity)
                                (item.price! * item.qty!).toString()),
                            style: styleSubPrice
                            //
                            ),
                        //      if (item.price.discountDetail != 0) ...[
                        // if (item.attributes?.discountDetail != 0) ...[
                        //   spaceH4,
                        //   Text(
                        //     '- ${defaultCurrencyVNDFormatter.formatString((item.attributes?.discountDetail).toString())}',
                        //     style: textTheme.bodyMedium?.copyWith(
                        //       color: colorGray03,
                        //     ),
                        //   ),
                        // ]
                      ],
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
