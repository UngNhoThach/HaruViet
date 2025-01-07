import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/theme/theme.dart';

class DidntFoundItem extends StatelessWidget {
  final bool isCartWidget;
  final Widget? widget;
  final String? title;
  final void Function()? onPressed;
  const DidntFoundItem({
    super.key,
    this.isCartWidget = false,
    this.widget,
    this.onPressed,
    this.title,
  });

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
            onPressed: onPressed ?? () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              title ?? "Mua sắm",
              style:
                  myThemeData.textTheme.titleLarge?.copyWith(color: colorWhite),
            ),
          ),
        ],
      ),
    );
  }
}
