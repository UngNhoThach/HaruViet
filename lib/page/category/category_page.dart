import 'package:haruviet/component/error/error_internet.dart';
import 'package:haruviet/component/input/search_bar.dart';
import 'package:haruviet/data/reponsitory/category/item_category_response.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/page/category/models/category_paga_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.params});
  final CategoryPageParams params;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // variables and functions

  List<ItemCategoryResponse> listCategories() {
    return [
      ItemCategoryResponse(
          id: 1, code: 'CAT001', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      ItemCategoryResponse(
          id: 2, code: 'CAT002', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      ItemCategoryResponse(
          id: 3, code: 'CAT003', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      ItemCategoryResponse(
          id: 4, code: 'CAT004', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      ItemCategoryResponse(
          id: 5, code: 'CAT005', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      ItemCategoryResponse(
          id: 6, code: 'CAT006', name: 'Mỹ phẩm High', isCheck: false),
      ItemCategoryResponse(
          id: 7, code: 'CAT007', name: 'Mỹ phẩm High-End', isCheck: false),
      ItemCategoryResponse(
          id: 8, code: 'CAT008', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      ItemCategoryResponse(
          id: 9, code: 'CAT009', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      ItemCategoryResponse(
          id: 10, code: 'CAT0010', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      ItemCategoryResponse(
          id: 11, code: 'CAT0011', name: 'Sức khoẻ & làm đẹp', isCheck: false),
      // Thêm các danh mục giả lập khác nếu cần
    ];
  }

  List<ItemCategoryResponse> listCategorie = [];

  @override
  void initState() {
    super.initState();
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                            color: colorGray04,
                            height: 1,
                          ),
                          shrinkWrap: true,
                          itemCount: listCategories().length,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  listCategories()
                                      .asMap()
                                      .forEach((key, value) {
                                    value.isCheck = true;
                                  });
                                });
                              },
                              child: Container(
                                padding: listCategories()[index].isCheck
                                    ? EdgeInsets.only(
                                        left: 8.w,
                                        right: 6.w,
                                        top: 16,
                                        bottom: 16.h,
                                      )
                                    : EdgeInsets.only(
                                        left: 8.w,
                                        right: 6.w,
                                        top: 16.h,
                                        bottom: 16.h,
                                      ),
                                decoration: listCategories()[index].isCheck
                                    ? BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              width: 6.0.w, color: colorMain),
                                        ),
                                        color: Colors.white,
                                      )
                                    : const BoxDecoration(
                                        color: colorBlueGray01,
                                      ),
                                child: Row(
                                  children: [
                                    Flexible(
                                        child: Text(
                                      '${listCategories()[index].name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: colorBlackTileItem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Container(
                      // color: colorWhite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _category(context),
                        ],
                      ),
                    )),
              ],
            ),
          ],
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

  Widget _category(BuildContext context) {
    return Container(
      color: colorWhite,
      padding: EdgeInsets.only(top: 16.h, bottom: 40.h, left: 6.w, right: 6.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 40,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              routeService.pushNamed(
                Routes.categoryChildPage,
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: colorWhite,
                  ),
                  child: Wrap(alignment: WrapAlignment.center, children: [
                    Container(
                      color: colorTransparent,
                      child: Image.network(
                        'https://dienmaygiakho79.com/wp-content/uploads/2022/08/tu-lanh-thong-minh-toshiba-inverter-gr-rf605wi-pmv06-mg-4.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        colorBlendMode:
                            BlendMode.dstATop, // Kích hoạt kết hợp màu sắc
                        errorBuilder: (context, error, stackTrace) {
                          return const ErrorInternet();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Text(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        'Chăm sóc tóc và da đầu của giới trẻ',
                        style: textTheme.bodySmall?.copyWith(color: colorBlack),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
