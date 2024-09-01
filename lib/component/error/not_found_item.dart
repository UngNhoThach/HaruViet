import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/helper/theme.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/utils/commons.dart';

class DidntFoundItem extends StatelessWidget {
  final bool isCartWidget;
  final Widget? widget;
  const DidntFoundItem({super.key, this.isCartWidget = false, this.widget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget ?? space0,
          isCartWidget
              ? Column(
                  children: [
                    SizedBox(
                      child: Icon(
                        color: colorBlueGray02,
                        Icons.add_shopping_cart_rounded,
                        size: 160.r,
                      ),
                    ),
                    Text('Giỏ hàng trống',
                        style: myThemeData.textTheme.headlineSmall),
                  ],
                )
              : space0,
          spaceH12,
          ElevatedButton(
            onPressed: () {
              routeService.pushNamed(Routes.productListPage,
                  arguments: ProductListPageParams());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorMain,
            ),
            child: Text(
              "Mua sắm",
              style:
                  myThemeData.textTheme.titleLarge?.copyWith(color: colorWhite),
            ),
          ),
        ],
      ),
    );
  }
}
