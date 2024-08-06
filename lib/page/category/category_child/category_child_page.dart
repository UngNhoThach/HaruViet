import 'package:haruviet/component/input/search_bar.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/product/detail/product_deatail_page.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryChildPage extends StatefulWidget {
  const CategoryChildPage({super.key});

  @override
  State<CategoryChildPage> createState() => _CategoryChildPageState();
}

class _CategoryChildPageState extends State<CategoryChildPage> {
  // variables and functions
  bool checkIsChangeListItem = false;
  final items = [
    "5-7 Years",
    "8-13 Years",
    "14+ Years",
    "8-13 Years",
    "14+ Years",
    "8-13 Years",
    "14+ Years",
    "8-13 Years",
    "14+ Years",
  ];
  List<String> selectedItem = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _buildSearchField(),
        backgroundColor: colorMain,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              routeService.pushNamed(Routes.cartPage,
                  arguments: CartPageParams(isAppBar: true));
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: colorWhite,
              weight: 2.5,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                checkIsChangeListItem = !checkIsChangeListItem;
              });
            },
            icon: Icon(
              checkIsChangeListItem
                  ? Icons.border_all
                  : Icons.format_line_spacing_outlined,
              color: colorWhite,
              weight: 2.5,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FilterCategoryList(

          //   statusSelected: 4,
          //   onSelect: () {},
          // ),
          // Divider(),
          // wating for check it
          // FilterProductList(
          //   statusSelected: 2,
          //   onSelect: () {},
          // ),
          checkIsChangeListItem
              ? Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          _flashDealsProductGridView(context),
                          const SizedBox(
                            height: 72,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      spaceH8,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => ProductDetailPage(
                                              params: ProductDetailParams(
                                                  idProduct: '0'),
                                            )));
                              },
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                              child: Image.network(
                                                'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.16,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 16.h,
                                                  left: 4.w,
                                                  right: 4.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '900.000 đ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                              color: colorMain,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                      Text(
                                                        '1.200.000 đ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                              color:
                                                                  colorItemCover,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Thương hiệu: Samsung',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                          color:
                                                              colorSecondary04,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Tủ lạnh Samsung Inverter 599 lít',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                          color:
                                                              colorBlackTileItem,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 42.w,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color:
                                                                  colorMainCover,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4,
                                                                    vertical:
                                                                        2),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '4.8',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelSmall
                                                                      ?.copyWith(
                                                                        color:
                                                                            colorBackgroundWhite,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                                spaceW2,
                                                                Icon(
                                                                  Icons.star,
                                                                  size: 12.sp,
                                                                  color:
                                                                      colorBackgroundWhite,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          spaceW2,
                                                          Text(
                                                            '(120)',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall
                                                                ?.copyWith(
                                                                  color:
                                                                      colorBlueGray02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .shopping_cart_outlined,
                                                            color:
                                                                colorBlueGray02,
                                                            size: 12.sp,
                                                          ),
                                                          spaceW2,
                                                          Text(
                                                            '1.3k/tháng',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall
                                                                ?.copyWith(
                                                                  color:
                                                                      colorBlueGray02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),

                                                  spaceH6,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            gradient:
                                                                LinearGradient(
                                                              stops: const [
                                                                0.6,
                                                                0.02
                                                              ],
                                                              colors: [
                                                                colorMainCover,
                                                                colorMainCover
                                                                    .withOpacity(
                                                                        0.4),
                                                              ],
                                                            ),
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.w,
                                                                  vertical:
                                                                      2.h),
                                                          child: Text(
                                                            'Còn: 01 : 37: 00',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall
                                                                ?.copyWith(
                                                                  color:
                                                                      colorWhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                            ?.copyWith(
                                                                color:
                                                                    colorMain),
                                                      ),
                                                    ],
                                                  ),

                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: [
                                                  //     InkWell(
                                                  //       onTap: () {},
                                                  //       child: Container(
                                                  //         width:
                                                  //             MediaQuery.of(context)
                                                  //                     .size
                                                  //                     .width *
                                                  //                 0.15,
                                                  //         decoration: BoxDecoration(
                                                  //             borderRadius:
                                                  //                 BorderRadius
                                                  //                     .circular(8),
                                                  //             color:
                                                  //                 colorSuccess01),
                                                  //         padding: const EdgeInsets
                                                  //             .symmetric(
                                                  //             horizontal: 4,
                                                  //             vertical: 2),
                                                  //         child: Row(
                                                  //           mainAxisAlignment:
                                                  //               MainAxisAlignment
                                                  //                   .center,
                                                  //           children: [
                                                  //             Icon(
                                                  //                 Icons
                                                  //                     .shopping_cart_checkout_outlined,
                                                  //                 size: 20,
                                                  //                 color:
                                                  //                     colorSuccess03),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //     InkWell(
                                                  //       onTap: () {},
                                                  //       child: Container(
                                                  //         width:
                                                  //             MediaQuery.of(context)
                                                  //                     .size
                                                  //                     .width *
                                                  //                 0.15,
                                                  //         decoration: BoxDecoration(
                                                  //             borderRadius:
                                                  //                 BorderRadius
                                                  //                     .circular(8),
                                                  //             color: colorError01),
                                                  //         padding: const EdgeInsets
                                                  //             .symmetric(
                                                  //             horizontal: 4,
                                                  //             vertical: 2),
                                                  //         child: Row(
                                                  //           mainAxisAlignment:
                                                  //               MainAxisAlignment
                                                  //                   .center,
                                                  //           children: [
                                                  //             Icon(Icons.favorite,
                                                  //                 size: 20,
                                                  //                 color:
                                                  //                     colorError03),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          },
                          itemCount: 8,
                          separatorBuilder: (context, index) => const Divider(
                            color: colorBlueGray03,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
        ],
      ),
    );
  }

  Widget _flashDealsProductGridView(BuildContext context) {
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => ProductDetailPage(
                            params: ProductDetailParams(idProduct: ''),
                          )));
              //ProductDetailPage
            },
            child: Container(
              height: 300.h,
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
                        Row(
                          children: [
                            Text(
                              '900.000 đ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    color: colorMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              '1.200.000 đ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
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

  Widget _buildSearchField() {
    return AppSearchBar(
      hintText: 'Tìm kiếm sản phẩm',
      onChanged: (keyword) {
        setState(() {
          // keywordText = keyword;
          // _onTapWorkPlan = !_onTapWorkPlan;
        });
      },
    );
  }
}
