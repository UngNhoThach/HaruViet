import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';

class BrandItem extends StatelessWidget {
  final String assetImageString;
  final String itemString;
  final dynamic destinationWidget;
  final void Function()? onTap;
  final double? width;
  final double? height;

  const BrandItem({
    super.key,
    this.destinationWidget,
    this.width,
    this.height,
    required this.assetImageString,
    required this.itemString,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            destinationWidget == null
                ? CustomSnackBar.showTop(
                    context, 'Chức năng đang được phát triển', null)
                : Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => destinationWidget));
          },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Wrap(alignment: WrapAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: width ?? 80.w,
              //  height: height ?? 82.h,
              decoration: BoxDecoration(
                color: colorWhite,
                // border: Border.all(color: colorMainCover, width: 2),
                borderRadius: BorderRadius.circular(2.0.r),
              ),
              child: Column(
                children: [
                  spaceH8,
                  Center(
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      fadeOutDuration: const Duration(seconds: 1),
                      //  const Duration(seconds: 3),
                      imageUrl: assetImageString,
                      width: width != null ? width! * 0.68 : 60.w,
                      //        height: height != null ? height! * 0.8 : 42.h,

                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  spaceH8,
                  Text(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    '$itemString\n',
                    style: const TextStyle(
                      fontSize: 16,
                      color: colorBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
