import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/products_recommendation/products_recommendation_database.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/home/widgets/count_dount.dart';
import 'package:haruviet/page/product/detail/product_deatail_page.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/page/product/widgets/dot_border_product.dart';
import 'package:haruviet/page/product/widgets/text_with_minline.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';

class ItemProductWidget {
  ItemProductWidget();

  //  productsList = await CartDatabaseV2().getAllProducts();

  Widget itemRow(
    BuildContext context, {
    required DataProduct data,
    required int index,
    required String domain,
  }) {
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => ProductDetailPage(
                      params: ProductDetailParams(idProduct: data.id ?? ''),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  fadeOutDuration: const Duration(seconds: 3),
                  imageUrl: '$domain${data.image}',
                  width: 100.w,
                  height: 90.h,
                  // placeholder: (context, url) =>
                  //     ImageProductShimer(height: 90.h, width: 100.h),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(top: 16.h, left: 4.w, right: 4.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.discount == null
                              ? '${data.price?.priceStr}'
                              : '${data.discount?.pricePromotion?.priceStr}',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        data.discount == null
                            ? space0
                            : Text(
                                '${data.price?.priceStr}',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorItemCover,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    (data.descriptions == null)
                        ? space0
                        : Text(data.descriptions?.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      data.brand?.name ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorSecondary04,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 42.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColorLight,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: Row(
                                children: [
                                  Text(
                                    data.reviews?.averageRating.toString() ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: colorBackgroundWhite,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  spaceW2,
                                  Icon(
                                    Icons.star,
                                    size: 12.sp,
                                    color: colorBackgroundWhite,
                                  ),
                                ],
                              ),
                            ),
                            spaceW2,
                            Text(
                              '(${data.reviews?.averageRating.toString() ?? ''})',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: colorBlueGray02,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: colorBlueGray02,
                              size: 12.sp,
                            ),
                            spaceW2,
                            Text(
                              '${data.sold} mua',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: colorBlueGray02,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    spaceH6,
                    data.discount?.dateEnd != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color:
                                          Theme.of(context).primaryColorLight),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: CountdownTimer(
                                        dateStart:
                                            data.discount?.dateStart ?? '',
                                        dateEnd: data.discount?.dateEnd ?? ''),
                                  ),
                                ),
                              ),
                              spaceW4,
                            ],
                          )
                        : space0,
                    // start dot borders
                    (data.promotiondetails == null ||
                            data.promotiondetails!.isEmpty ||
                            data.promotiondetails![0] == null)
                        ? space0
                        : DotBorderProduct(
                            value: data.promotiondetails?[0]?.description ?? '',
                          ),
                    // end dot borders
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemGridView(BuildContext context,
      {required DataProduct data,
      required int index,
      required String domain,
      double? height}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            routeService.pushNamed(Routes.productDetailPage,
                arguments: ProductDetailParams(idProduct: data.id ?? ''));

            // insert to product recommendations list
            await ProductRecommendationDatabase()
                .insertProductFromDataProductRecommen(product: data);
          },
          child: Stack(
            children: [
              Container(
                height: height,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: colorWhite,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 6,
                      color:
                          colorGray02, // Theme.of(context).primaryColorLight,
                      offset: Offset(1, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.r),
                                bottomRight: Radius.circular(0.r),
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r),
                              ),
                              child: CachedNetworkImage(
                                fadeOutDuration: const Duration(seconds: 3),
                                //  const Duration(seconds: 3),
                                imageUrl: '$domain${data.image}',
                                width: 72,
                                height: 72,
                                // placeholder: (context, url) =>
                                //     const ImageProductShimer(
                                //   width: 72,
                                //   height: 72,
                                // ), // Use the custom shimmer component
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 16, left: 4, right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.discount == null
                                      ? '${data.price?.priceStr}'
                                      : '${data.discount?.pricePromotion?.priceStr}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                data.discount == null
                                    ? space0
                                    : Text(
                                        '${data.price?.priceStr}',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colorItemCover,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                              ],
                            ),
                            spaceH4,
                            (data.descriptions == null)
                                ? space0
                                : TextWithMinLines(
                                    minLines: 2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    data.descriptions?.name ?? '',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: colorBlackTileItem,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            spaceH4,
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              data.brand?.name ?? '',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorSecondary04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            spaceH4,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 2.h),
                                      child: Row(
                                        children: [
                                          Text(
                                            data.reviews?.averageRating
                                                    .toString() ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: colorBackgroundWhite,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          spaceW2,
                                          Icon(
                                            Icons.star,
                                            size: 10.sp,
                                            color: colorBackgroundWhite,
                                          ),
                                        ],
                                      ),
                                    ),
                                    spaceW2,
                                    Text(
                                      data.sold == null
                                          ? '0'
                                          : formattedNumber(
                                              data.reviews?.averageRating),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: colorBlueGray02,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: colorBlueGray02,
                                      size: 12.sp,
                                    ),
                                    spaceW2,
                                    Text(
                                      data.sold == null
                                          ? '0'
                                          : formattedNumber(data.sold),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: colorBlueGray02,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            (data.discount == null ||
                                    (data.discount?.dateStart == '') ||
                                    data.discount?.dateEnd == null)
                                ? space0
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w, vertical: 2),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: CountdownTimer(
                                                  dateStart: data.discount
                                                          ?.dateStart ??
                                                      '',
                                                  dateEnd:
                                                      data.discount?.dateEnd ??
                                                          ''),
                                            )),
                                      ),
                                      spaceW4,
                                    ],
                                  ),
                            // start dot borders
                            (data.promotiondetails == null ||
                                    data.promotiondetails!.isEmpty ||
                                    data.promotiondetails![0] == null)
                                ? space0
                                : DotBorderProduct(
                                    value: data.promotiondetails?[0]
                                            ?.description ??
                                        '',
                                  ),

                            // end dot borders
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (data.discount != null) ...[
                (data.discount?.dateEnd != null)
                    ? Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child:
                              // Image.asset(
                              //   Assets.icons.filterHotDeal.path,
                              //   scale: 2,
                              //   fit: BoxFit.fill,
                              // )
                              Text(
                            'Flash Sale',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      )
                    : space0,
                (data.discount?.percent != 0.0 &&
                        data.discount?.percent != null)
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomLeft: Radius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            '- ${(removeZeroDouble(value: data.discount!.percent!))}%',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: colorBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      )
                    : space0,
              ],
            ],
          ),
        ),
      ],
    );
  }

  removeZeroDouble({required double value}) {
    return formatDouble(value);
  }

  Path customPath = Path()
    ..moveTo(20, 20)
    ..lineTo(20, 20)
    ..lineTo(20, 20)
    ..lineTo(20, 20)
    ..lineTo(20, 20);
}
