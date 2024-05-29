import 'package:eco_app/component/input/search_bar.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/core/product_data.dart';
import 'package:eco_app/page/home/widgets/flash_deals.dart';
import 'package:eco_app/page/home/widgets/home_icon.dart';
import 'package:eco_app/page/product_list/product_list_page.dart';
import 'package:eco_app/qr/qr_page.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables and functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: _buildSearchField(),
      //   backgroundColor: colorMain,
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () {
      //         routeService.pushNamed(Routes.cartPage,
      //             arguments: CartPageParams(isAppBar: true));
      //       },
      //       icon: Icon(
      //         Icons.shopping_cart_outlined,
      //         color: colorWhite,
      //         weight: 2.5.sp,
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              _recommendedProductListView(context),
              Column(
                children: [
                  spaceH16,
                  _homeIcon(context),
                  spaceH20,
                ],
              ),
              _topCategoriesHeader(context,
                  title: "Siêu ưu đãi", isTimer: true),
              spaceH4,
              _flashDealsProductListView(context),
              _topCategoriesHeader(context,
                  title: "Sản phẩm mới", isTimer: false),
              // spaceH16,
              _flashDealsProductGridView(context),
              _topCategoriesHeader(context,
                  title: "Sản phẩm bán chạy", isTimer: false),
              // spaceH16,
              _flashDealsProductGridView(context),
              spaceH72,
            ],
          ),
        ),
      ),
    );
  }

  // widgets
  Widget _buildSearchField() {
    return AppSearchBar(
      hintText: 'Tìm kiếm  ',
      onChanged: (keyword) {
        setState(() {
          // keywordText = keyword;
        });
      },
    );
  }
}

Widget _recommendedProductListView(BuildContext context) {
  return SizedBox(
    height: 180.h,
    child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: AppData.recommendedProducts.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              width: 300.w,
              decoration: BoxDecoration(
                color: AppData.recommendedProducts[index].cardBackgroundColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Giảm giá 30%  \nCOVID 19',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        spaceH8,
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppData.recommendedProducts[index]
                                .buttonBackgroundColor,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Text(
                            "Xem ngay",
                            style: TextStyle(
                              color: AppData
                                  .recommendedProducts[index].buttonTextColor!,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/shopping.png',
                    height: 125.h,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget _flashDealsProductGridView2(BuildContext context) {
  double screenWeight = MediaQuery.of(context).size.width;

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisExtent: 280.h,
      crossAxisCount: 2,
      crossAxisSpacing: 4.w,
      mainAxisSpacing: 4.w,
    ),
    // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        semanticContainer: true,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 300.h,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  child: Image.network(
                    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                spaceH20,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceH6,
                      Row(
                        children: [
                          Text(
                            '900.000 đ',
                            style: textTheme.subtitle1?.copyWith(
                              color: colorMain,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '1.200.000 đ',
                            style: textTheme.subtitle2?.copyWith(
                              color: colorItemCover,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      spaceH4,
                      Text(
                        'Thương hiệu: Samsung',
                        style: textTheme.caption?.copyWith(
                          color: colorSecondary04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              maxLines: null,
                              'Tủ lạnh Samsung Inverter 599 lít',
                              style: textTheme.caption?.copyWith(
                                color: colorBlackTileItem,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      spaceH6,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 42.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: colorMainCover,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 2.h),
                                child: Row(
                                  children: [
                                    Text(
                                      '4.8',
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
                                '(120)',
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
                                '1.3k/tháng',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  stops: const [0.6, 0.02],
                                  colors: [
                                    colorMainCover,
                                    colorMainCover.withOpacity(0.4),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: Text(
                                'Còn: 01 : 37: 00',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: colorWhite,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                          spaceW4,
                          Text(
                            '60%',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: colorMain),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _flashDealsProductGridView(BuildContext context) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisExtent: 280.h,
      crossAxisCount: 2,
      crossAxisSpacing: 4.w,
      mainAxisSpacing: 4.w,
    ),
    // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        semanticContainer: true,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: InkWell(
          onTap: () {
            routeService.pushNamed(Routes.productDetailPage);
          },
          child: Container(
            // height: 26.h,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  child: Image.network(
                    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                spaceH20,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceH6,
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                '900.000 đ',
                                maxLines: null,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: colorMain,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '1.200.000 đ',
                                maxLines: null,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontSize: 11,
                                      color: colorItemCover,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      spaceH4,
                      Text(
                        'Thương hiệu: Samsung',
                        style: textTheme.caption?.copyWith(
                          color: colorSecondary04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              maxLines: null,
                              'Tủ lạnh Samsung Inverter 599 lít',
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: colorBlackTileItem,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      spaceH6,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 42.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: colorMainCover,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 2.h),
                                child: Row(
                                  children: [
                                    Text(
                                      '4.8',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: colorBackgroundWhite,
                                            fontWeight: FontWeight.bold,
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
                                '(120)',
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
                                '1.3k/tháng',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  stops: const [0.6, 0.02],
                                  colors: [
                                    colorMainCover,
                                    colorMainCover.withOpacity(0.4),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: Text(
                                'Còn: 01 : 37: 00',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: colorWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          spaceW4,
                          Text(
                            '60%',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: colorMain),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _flashDealsProductListView(BuildContext context) {
  return SizedBox(
    height: 280.h,
    child: ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: AppData.recommendedProducts.length + 4,
      separatorBuilder: (_, __) => spaceW12,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            routeService.pushNamed(Routes.productDetailPage);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                  blurRadius: 4,
                  color: Color(0x3600000F),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.46,
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
                          child: Image.network(
                            'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16.h, left: 4.w, right: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '900.000 đ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: colorMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              '1.200.000 đ',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorItemCover,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        spaceH4,
                        Text(
                          'Thương hiệu: Samsung',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorSecondary04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        spaceH4,
                        Text(
                          'Tủ lạnh Samsung Inverter 599 lít',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorBlackTileItem,
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
                                  width: 42.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: colorMainCover,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        '4.8',
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
                                  '(120)',
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
                                  '1.3k/tháng',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  gradient: LinearGradient(
                                    stops: const [0.6, 0.02],
                                    colors: [
                                      colorMainCover,
                                      colorMainCover.withOpacity(0.4),
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 2.h),
                                child: Text(
                                  'Còn: 01 : 37: 00',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: colorWhite,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                            spaceW4,
                            Text(
                              '60%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: colorMain),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget _topCategoriesHeader(
  BuildContext context, {
  required final String title,
  required bool isTimer,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        isTimer ? FlashDealsTimer() : SizedBox(),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => const ProductListPage()));
          },
          child: Text(
            "Xem tất cả",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.deepOrange.withOpacity(0.7)),
          ),
        )
      ],
    ),
  );
}

Widget _homeIcon(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: const Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            HomePageIcon(
              assetImageString: 'assets/images/qr_png.png',
              itemString: "Mã QR của tôi",
              destinationWidget: QrCodePage(),
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/recruitment.png',
              itemString: "Hàng mới về",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/maneuver.png',
              itemString: "Giao 2h",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/education.png',
              itemString: "Bảng giá",
              destinationWidget: null,
              notifyNumber: "0",
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 32,
      ),
      Container(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: const Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            HomePageIcon(
              assetImageString: 'assets/images/user_information.png',
              itemString: "Tra cứu đơn hàng",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/recruitment.png',
              itemString: "Mua 1 tặng 1",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/maneuver.png',
              itemString: "Cẩm nang",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/education.png',
              itemString: "Thông báo",
              destinationWidget: null,
              notifyNumber: "0",
            ),
          ],
        ),
      ),
    ],
  );
}
