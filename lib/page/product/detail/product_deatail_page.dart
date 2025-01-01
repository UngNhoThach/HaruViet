import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/component/html_convert/customer_html_view.dart';
import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/component/popup/alert/alert_one_button.dart';
import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:badges/badges.dart' as badges;
import 'package:haruviet/component/rowcontent/rowcontent_one_column.dart';
import 'package:haruviet/component/rowcontent/rowcontent_v1.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/product_promotion_price_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/promotiondetail_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/reviews_response/data_reviews.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/gen/assets.gen.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/shadows.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/category/category_child/widgets/sub_category_params.dart';
import 'package:haruviet/page/product/widgets/header_top_widget.dart';
import 'package:haruviet/page/home/widgets/count_dount.dart';
import 'package:haruviet/page/home/widgets/scroll_to_top_widget.dart';
import 'package:haruviet/page/product/detail/product_detail_bloc.dart';
import 'package:haruviet/page/product/detail/product_detail_state.dart';
import 'package:haruviet/page/product/detail/widgets/popup_show_option_product.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/widget_value_select.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/count_qualition.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/product_params.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/review_file.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/scoll_to_hide_bottom_bar.dart';
import 'package:haruviet/page/product/widgets/item_products_widget.dart';
import 'package:haruviet/page/product/widgets/widget_products_one_row_not_loading.dart';
import 'package:haruviet/page/review/write_review/widgets/write_review_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailParams params;

  const ProductDetailPage({super.key, required this.params});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // variables and functions
  late ProductDetailBloc bloc;
  late String domain;
  int? replyId;
  final ItemProductWidget itemProductWidgets = ItemProductWidget();
  final _controller = PageController();

  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();
  bool isFetchingData = false;

  //  hide bottom

  int length = 0;

  @override
  void initState() {
    domain = context.read<SettingAppBloc>().state.xUrl ?? '';

    bloc = ProductDetailBloc(context)..getData(widget.params.idProduct, domain);

    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onFetch(page: pageKey);
      }
    });

    _onScroll();
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _scrollController.addListener(() {
      if (bloc.canLoadMoreRecommendationProduct &&
          _scrollController.position.extentAfter < 500) {
        if (!isFetchingData) {
          if (_pagingController.nextPageKey == startPage) {
          } else {
            isFetchingData = true;
            _pagingController
                .notifyPageRequestListeners(_pagingController.nextPageKey!);
            bloc.stream.listen((state) {
              if (!state.isLoading) {
                isFetchingData = false;
              }
            });
          }
        }
      }
    });
  }

  int currentIndex = 0;
  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 1);

  final Map<String, dynamic>? dataSupport = {
    'Linh hoạt':
        'Với lỗi trên của lái xe Q., tổ kiểm tra đã tạm giữ bằng lái 7 ngày, xử phạt hành chính 500.000 đồng. Ngoài ra lực lượng chức năng đã buộc chủ xe tháo dỡ hàng hóa cồng kềnh và yêu cầu tháo ngay chiếc xe tự chế đi kèm. ổ kiểm tra đã tạm giữ bằng lái 7 ngày, xử phạt hành chính 500.000 đồng. Ngoài ra lực lượng chức năng đã buộc chủ xe tháo dỡ hàng hóa cồng kềnh và yêu cầu tháo ngay chiếc xe tự chế đi kèm. Trao đổi với PV, Đại úy Bùi Thành Tuyên, Tổ trưởng tổ công tác cho biết, các trường hợp chở hàng cồng kềnh, quá giới hạn là một trong những nguyên nhân dẫn tới các vụ tai nạn giao thông trên đường. Tất cả các trường hợp vi phạm đều bị xử lý nghiêm theo quy định pháp luật. Tại điểm k khoản 3 Điều 6 của Nghị định 100/2019/NĐ-CP về quy định xử phạt vi phạm hành chính trong lĩnh vực giao thông đường bộ và đường sắt quy định mức phạt tiền 400.000-600.000 đồng đối với một trong các hành vi vi phạm sau đây: "Người điều khiển xe hoặc người ngồi trên xe bám, kéo, đẩy xe khác, vật khác, dẫn dắt súc vật, mang vác vật cồng kềnh; người được chở trên xe đứng trên yên, giá đèo hàng hoặc ngồi trên tay lái; xếp hàng hóa trên xe vượt quá giới hạn quy định...',
  };

  bool showAllComments = false;

  Widget _shimmer(BuildContext context, {double? height}) {
    return ShimmerEffect(
      child: Container(
        color: Colors.white, // Set your desired background shimmer color here
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          separatorBuilder: (context, index) => spaceH12,
          itemCount: 1,
        ),
      ),
    );
  }

  void _showCustomAlertDialog(BuildContext context, String meess) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomCupertinoAlertOneButton(
        title: '',
        content: meess,
        onPositiveButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProductDetailBloc, ProductDetailState>(
            listenWhen: (previous, current) =>
                previous.newDataList != current.newDataList ||
                previous.message != current.message,
            listener: (context, state) {
              if (state.message != null) {
                CustomSnackBar.showTop(context, state.message!, null);
              }
              if (state.currentPage == startPage) {
                _pagingController.refresh();
              }
              if (state.canLoadMoreRecommendationProduct) {
                _pagingController.appendPage(
                  state.newDataList ?? [],
                  state.currentPage + 1,
                );
              } else {
                _pagingController.appendLastPage(state.newDataList ?? []);
              }
            },
          ),
          BlocListener<ProductDetailBloc, ProductDetailState>(
            listenWhen: (previous, current) {
              return previous.checkProductInCart != current.checkProductInCart;
            },
            listener: (context, state) {
              state.checkProductInCart == true
                  ? _showCustomAlertDialog(
                      context, 'Sản phẩm đã tồn tại trong giỏ hàng')
                  : null;
            },
          ),
          // check it here
        ],
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            return LoadingScaffold(
                overlayOpacity: 1,
                overlayBackgroundColor: colorWhite,
                isLoading: state.isLoading,
                child: Builder(builder: (context) {
                  final product = state.dataProduct;

                  return GestureDetector(
                    onTap: () {
                      _focusNode.unfocus();
                    },
                    child: Scaffold(
                      floatingActionButton: ScrollToTopButton(
                        showOffset: 200,
                        scrollController: _scrollController,
                        backgroundColor: colorGray04.withOpacity(0.3),
                        iconColor: colorWhite,
                      ),
                      body: Builder(builder: (context) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            _pagingController.refresh();
                            bloc.onFetch(page: startPage);
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  spaceH36,
                                  state.isLoading
                                      ? _shimmer(context)
                                      : Expanded(
                                          child: CustomScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            slivers: [
                                              SliverList(
                                                  delegate:
                                                      SliverChildListDelegate(
                                                          addAutomaticKeepAlives:
                                                              true,
                                                          addRepaintBoundaries:
                                                              true,
                                                          [
                                                    Column(
                                                      children: [
                                                        spaceH16,
                                                        // widget image view
                                                        _widgetImageView(
                                                            description: state
                                                                    .dataProduct
                                                                    ?.descriptions
                                                                    ?.name ??
                                                                '',
                                                            imageUrls: state
                                                                .imageUrls),
                                                        spaceH6,

                                                        Container(
                                                          color: colorGray02,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.r),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    product?.discount ==
                                                                            null
                                                                        ? '${product?.price?.priceStr}'
                                                                        : '${product?.discount?.pricePromotion?.priceStr}',
                                                                    style: textTheme
                                                                        .titleLarge
                                                                        ?.copyWith(
                                                                            color:
                                                                                Theme.of(context).primaryColor,
                                                                            fontWeight: FontWeight.bold),
                                                                  ),
                                                                  spaceH4,
                                                                  product?.discount ==
                                                                          null
                                                                      ? space0
                                                                      : Text(
                                                                          '${product?.price?.priceStr}',
                                                                          style: textTheme
                                                                              .bodyMedium
                                                                              ?.copyWith(
                                                                            color:
                                                                                colorItemCover,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            decoration:
                                                                                TextDecoration.lineThrough,
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                              product?.discount !=
                                                                      null
                                                                  ? _widgetDiscount(
                                                                      discount:
                                                                          product!
                                                                              .discount)
                                                                  : space0,
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          color: colorWhite,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.r),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    // name product
                                                                    product?.descriptions?.name ==
                                                                            null
                                                                        ? space0
                                                                        : _widgetTitle(
                                                                            style:
                                                                                textTheme.titleMedium?.copyWith(
                                                                              color: Theme.of(context).primaryColor,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                            value: product?.descriptions?.name ?? ''),

                                                                    // SKU
                                                                    product?.sku ==
                                                                            null
                                                                        ? space0
                                                                        : _widgetTitle(
                                                                            style: textTheme.bodyMedium
                                                                                ?.copyWith(
                                                                              color: colorGray04,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                            label:
                                                                                'SKU: ',
                                                                            value:
                                                                                product?.sku ?? ''),

                                                                    // brand
                                                                    product?.brand ==
                                                                            null
                                                                        ? space0
                                                                        : _widgetTitle(
                                                                            label:
                                                                                'Thương hiệu: ',
                                                                            value:
                                                                                product?.brand?.name ?? ''),
                                                                    spaceH6,
                                                                    // review
                                                                    _widgetReview(
                                                                        totalReview: product!.reviews ==
                                                                                null
                                                                            ? 0
                                                                            : product.reviews!.totalReviews ??
                                                                                0,
                                                                        valueView:
                                                                            product.view ??
                                                                                0,
                                                                        rangeReview: product.reviews ==
                                                                                null
                                                                            ? 0
                                                                            : product.reviews!.averageRating ??
                                                                                0),
                                                                    spaceW4,
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Divider(
                                                          height: 3,
                                                          color: colorGray03,
                                                        ),
                                                        Container(
                                                            color: colorWhite,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        16),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  flex: 5,
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        36.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      border: Border.all(
                                                                          color:
                                                                              colorGray02),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .call,
                                                                          color:
                                                                              colorWhite,
                                                                        ),
                                                                        spaceW16,
                                                                        const Text(
                                                                            'Gọi điện',
                                                                            style:
                                                                                TextStyle(color: colorWhite, fontWeight: FontWeight.bold)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 5,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      // check is login
                                                                      state.isLoginsSuccess
                                                                          ? state.checkProductAttributes
                                                                              ? _showPopupBuy(context, state, bloc, product)
                                                                              : {
                                                                                  bloc.onAddItemToCart(productParams: ProductParams(dataProduct: product), productId: product.id ?? '', quantity: 1),
                                                                                }
                                                                          : routeService.pushNamed(Routes.login, arguments: SignInParams(typeDirec: 1));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          36.h,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            colorPrimary,
                                                                        border: Border.all(
                                                                            color:
                                                                                colorGray02),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.shopping_cart_checkout_sharp,
                                                                            color:
                                                                                colorWhite,
                                                                          ),
                                                                          spaceW16,
                                                                          const Text(
                                                                              'Mua hàng',
                                                                              style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        const Divider(
                                                          height: 3,
                                                          color: colorGray03,
                                                        ),
                                                        // widget gift
                                                        product.promotiondetails !=
                                                                    null ||
                                                                product
                                                                    .promotiondetails!
                                                                    .isNotEmpty
                                                            ? Column(
                                                                children: product
                                                                    .promotiondetails!
                                                                    .map((promotiondetails) =>
                                                                        _gitWidget(
                                                                            promotiondetails:
                                                                                promotiondetails!))
                                                                    .toList(),
                                                              )
                                                            : space0,

                                                        Container(
                                                          color: colorWhite,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.r),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    spaceH6,
                                                                    Text(
                                                                      'Giao nhanh miễn phí ship tại 24 tỉnh thành toàn quốc',
                                                                      style: textTheme
                                                                          .titleSmall
                                                                          ?.copyWith(
                                                                        color: context
                                                                            .appColorScheme
                                                                            .colorExtendedTextTitleMedium,
                                                                      ),
                                                                    ),
                                                                    spaceH4,
                                                                    Container(
                                                                      child:
                                                                          Row(
                                                                        children: <Widget>[
                                                                          Icon(
                                                                            Icons.history,
                                                                            color:
                                                                                Colors.grey.shade500,
                                                                          ),
                                                                          spaceW12,
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              'Bạn muốn giao hàng trước 2h ngày mai. Đặt hàng trước 6h và chọn giao hàng 2h ở dưới phần thanh toán',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 2,
                                                                              style: textTheme.bodyMedium?.copyWith(
                                                                                color: colorGray05,
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Icon(
                                                                            Icons.navigate_next,
                                                                            color:
                                                                                Colors.grey.shade500,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    spaceW4,
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        spaceH12,

                                                        state.technical!.isEmpty
                                                            ? space0
                                                            : RowContent(
                                                                checkIspaddingTile:
                                                                    true,
                                                                title:
                                                                    'Thông tin sản phẩm',
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                data: state
                                                                    .technical,
                                                              ),

                                                        spaceH6,

                                                        state.htmlData == null
                                                            ? space0
                                                            : RowContentOneColumn(
                                                                checkIspaddingTile:
                                                                    true,
                                                                title: 'Mô tả',
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                widget:
                                                                    CustomHtmlViewer(
                                                                  htmlData: state
                                                                      .htmlData!,
                                                                  // staticAnchorKey:
                                                                  //     myAnchorKey,
                                                                  onLinkTap:
                                                                      (url, _,
                                                                          __) {
                                                                    debugPrint(
                                                                        "Tapped link: $url");
                                                                  },
                                                                ),
                                                                // data: state.dataDetail,
                                                              ),
                                                        product.reviews != null
                                                            ? space0
                                                            : spaceH12,
                                                        product.reviews != null
                                                            ? _reviewsWidget(
                                                                context,
                                                                itemProductDetailResponse:
                                                                    product)
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  routeService.pushNamed(
                                                                      Routes
                                                                          .writeReviewPage,
                                                                      arguments: WriteReviewParams(
                                                                          onReload:
                                                                              () {},
                                                                          itemProductDetailResponse:
                                                                              state.dataProduct));
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 36.h,
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          16),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        colorPrimary,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    border: Border.all(
                                                                        color:
                                                                            colorGray02),
                                                                  ),
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                          'Viết đánh giá',
                                                                          style: TextStyle(
                                                                              color: colorWhite,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                        // widget support

                                                        _wjdgetSupport(),

                                                        // widget recommen products
                                                        spaceH10,
                                                        state.productsListRecommendations
                                                                .isEmpty
                                                            ? space0
                                                            : _widgetRecommentProduct(
                                                                productsListRecommendations:
                                                                    state
                                                                        .productsListRecommendations),

                                                        // widget products brand
                                                        _widgetBrandProducts(
                                                          idBrand: state
                                                                  .dataProduct
                                                                  ?.brand
                                                                  ?.id ??
                                                              '',
                                                          productsListBrand: state
                                                              .datatListBrand,
                                                        ),
                                                        spaceH10,

                                                        // widget category products
                                                        _widgetCategoryProduct(
                                                            idCategory: state
                                                                    .idCategory ??
                                                                '',
                                                            nameCategory: state
                                                                    .nameCategory ??
                                                                ''),

                                                        // RowContentOneColumn(
                                                        //   // maxLines: 4,
                                                        //   // isPaddingTop: true,
                                                        //   title: 'Hướng dẫn sử dụng',

                                                        //   padding: EdgeInsets.zero,
                                                        //   data: dataSupport,
                                                        // ),

                                                        spaceH72,
                                                      ],
                                                    ),
                                                  ]))
                                            ],
                                            controller: _scrollController,
                                          ),
                                        ),
                                ],
                              ),
                              Positioned(
                                top: 10,
                                left: 0,
                                right: 0,
                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                  leading: IconButton(
                                    onPressed: () {
                                      context.justBack();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: colorBlack,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Consumer<CartProviderV2>(
                                      builder: (BuildContext context,
                                          CartProviderV2 value, Widget? child) {
                                        return badges.Badge(
                                          position: badges.BadgePosition.topEnd(
                                              top: 0, end: -8),
                                          showBadge: value.getCounter() == 0
                                              ? false
                                              : true,
                                          ignorePointer: false,
                                          badgeStyle: badges.BadgeStyle(
                                              badgeColor: Theme.of(context)
                                                  .primaryColor),
                                          badgeContent:
                                              Text('${value.counter}'),
                                          child: IconButton(
                                            onPressed: () {
                                              routeService.pushNamed(
                                                  Routes.cartPage,
                                                  arguments: CartPageParams(
                                                      isAppBar: true));
                                            },
                                            icon: Icon(
                                              Icons.shopping_cart_outlined,
                                              color: colorBlack,
                                              weight: 2.5.sp,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    spaceW16,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      // error when scoll this widget

                      bottomNavigationBar: ScollToHideBottomBar(
                        duration: const Duration(milliseconds: 300),
                        controller: _scrollController,
                        child: BottomBarButton(
                          // Theme.of(context).colorScheme.onBackground,
                          button1: AppSolidButton.medium(
                            context: context,
                            'Gọi điện',
                            onPressed: () {},
                          ),
                          button2: Consumer<CartProviderV2>(
                            builder: (context, provider, child) {
                              return AppSolidButton.medium(
                                color: colorPrimary,
                                context: context,
                                'Mua hàng',
                                onPressed: () async {
                                  state.isLoginsSuccess
                                      ? {
                                          bloc.onAddItemToCart(
                                              productParams: ProductParams(
                                                  dataProduct: product!),
                                              quantity:
                                                  product.totalQuantity ?? 0,
                                              productId: product.id ?? ''),
                                        }
                                      : routeService.pushNamed(Routes.login,
                                          arguments:
                                              SignInParams(typeDirec: 1));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }));
          },
        ),
      ),
    );
  }

  // widget support
  Widget _wjdgetSupport() {
    return Container(
        decoration: BoxDecoration(
            color: colorGreen.withOpacity(0.2), boxShadow: shadowE1),
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              Assets.icons.doitramienphi.path,
              scale: 3,
            ),
            Image.asset(
              Assets.icons.delivery.path,
              scale: 3,
            ),
            Image.asset(
              Assets.icons.freeship.path,
              scale: 3,
            ),
          ],
        ));
  }

  // widget image view
  Widget _widgetImageView({
    required List<String> imageUrls,
    required String description,
  }) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: imageUrls.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // unfocus textfield
                    FocusManager.instance.primaryFocus?.unfocus();
                    ReviewFiles.show(
                      imageScripts: [description],
                      context,
                      filesUrl: imageUrls,
                      initIndex: index,
                      onDelete: (index) {
                        // uploader.removeFileAtValue(
                        //     imageFiles[index], state.domainApi);
                      },
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    width: 60.w,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
          imageUrls.length > 2
              ? SmoothPageIndicator(
                  controller: _controller,
                  count: imageUrls.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                    activeDotColor: context.theme.primaryColor,
                    dotColor: context.theme.secondaryHeaderColor,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                )
              : space0,
          spaceH10,
        ],
      ),
    );
  }

  // widget product from category
  Widget _widgetCategoryProduct(
      {required String nameCategory, required String idCategory}) {
    return Column(
      children: [
        TopCategoriesHeader(
            backgroundColor: colorGray02,
            onPressed: () => routeService.pushNamed(Routes.subCategoryPage,
                arguments: CategoryParams(idCategory: idCategory)),
            isBorder: false,
            title: "Gợi ý dành cho bạn",
            isTimer: false),
        _buildPagedSliverGrid()
      ],
    );
  }

  Widget _itemGridView(
    BuildContext context, {
    required DataProduct data,
    required int index,
    required String domain,
  }) {
    return itemProductWidgets.itemGridView(
      context,
      data: data,
      index: index,
      domain: domain,
    );
  }

  Widget _buildPagedSliverGrid() {
    return MasonryGridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: _pagingController.itemList?.length ?? 0,
      itemBuilder: (context, index) {
        final item = _pagingController.itemList?[index];
        return _itemGridView(
          context,
          index: index,
          data: item!,
          domain: domain,
        );
      },
    );
  }

  // widget brand products
  Widget _widgetBrandProducts(
      {required List<DataProduct> productsListBrand, required String idBrand}) {
    return Column(
      children: [
        TopCategoriesHeader(
            onPressed: () => routeService.pushNamed(Routes.subCategoryPage,
                arguments: CategoryParams(
                  idBrand: idBrand,
                  idCategory: '',
                )),
            isBorder: true,
            title: "Sản phẩm cùng thương hiệu",
            isTimer: false),
        _itemsBrand(
          productsListBrand: productsListBrand,
        ),
      ],
    );
  }

  Widget _itemsBrand({required List<DataProduct> productsListBrand}) {
    return WidgetProductOneRowNotLoading(
      backroundColor: colorBlueGray01,
      physics: const BouncingScrollPhysics(),
      height: 270,
      items: productsListBrand,
      itemBuilder: (context, item, index) {
        return itemProductWidgets.itemGridView(
          context,
          data: item,
          index: index,
          domain: domain,
        );
      },
    );
  }

  // widget recommendations products
  Widget _widgetRecommentProduct(
      {required List<DataProduct> productsListRecommendations}) {
    return Column(
      children: [
        const TopCategoriesHeader(
            isViewMore: false,
            // onPressed: () => routeService.pushNamed(Routes.subCategoryPage,
            //     arguments: CategoryParams(
            //         idCategory: '', isProcuctRecommendation: true)),
            isBorder: true,
            title: "Sản phẩm vừa xem",
            isTimer: false),
        _itemsRecommendation(
            productsListRecommendations: productsListRecommendations),
      ],
    );
  }

  Widget _itemsRecommendation(
      {required List<DataProduct> productsListRecommendations}) {
    return WidgetProductOneRowNotLoading(
      physics: const BouncingScrollPhysics(),
      height: 270,
      items: productsListRecommendations,
      itemBuilder: (context, item, index) {
        return itemProductWidgets.itemGridView(
          height: 268,
          context,
          data: item,
          index: index,
          domain: domain,
        );
      },
    );
  }

  // widget empty products
  Widget _empty(BuildContext context) {
    return const DidntFound();
  }

  // widget review
  Widget _widgetReview(
      {required int rangeReview,
      required int valueView,
      required int totalReview}) {
    return Row(
      children: [
        Container(
          width: 46.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: Theme.of(context).primaryColorLight,
          ),
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              Text(
                rangeReview.toString(),
                style: textTheme.bodyMedium?.copyWith(
                  color: colorBackgroundWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
              spaceW2,
              Icon(
                Icons.star,
                size: 16.sp,
                color: colorBackgroundWhite,
              ),
            ],
          ),
        ),
        spaceW6,
        Text(
          '($totalReview)',
          style: textTheme.bodyMedium?.copyWith(
            color: colorSuccess03,
            fontWeight: FontWeight.w500,
          ),
        ),
        spaceW6,
        Text(
          'Đánh giá',
          style: textTheme.bodyMedium?.copyWith(
            color: colorSuccess03,
            fontWeight: FontWeight.w500,
          ),
        ),
        spaceW6,
        Text(
          '|',
          style: textTheme.bodyMedium?.copyWith(
            color: colorSuccess03,
            fontWeight: FontWeight.w500,
          ),
        ),
        spaceW6,
        spaceW2,
        Text(
          '$valueView lượt xem',
          style: textTheme.bodyMedium?.copyWith(
            color: colorSuccess03,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // widget title
  Widget _widgetTitle(
      {required String value, String? label, TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        label != null ? '$label $value' : value,
        style: style ??
            textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

// widget discount
  Widget _widgetDiscount({required ProductPromotionPriceList? discount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.r),
            color: Theme.of(context).primaryColorLight.withOpacity(0.8),
          ),
          padding: const EdgeInsets.all(4),
          child: CountdownTimer(
              dateStart: discount?.dateStart ?? '',
              dateEnd: discount?.dateEnd ?? ''),
        ),
        spaceH6,
        Row(
          children: [
            Text(
              '95% deal đã mua',
              style: textTheme.bodyMedium?.copyWith(
                color: colorGray05,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

// widget gift
  Widget _gitWidget({
    required Promotiondetail promotiondetails,
  }) {
    return Container(
      color: colorWhite,
      padding: EdgeInsets.all(8.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH4,
                Row(
                  children: [
                    Icon(
                      Icons.card_giftcard_sharp,
                      color: Theme.of(context).primaryColorLight,
                      size: 30,
                    ),
                    spaceW10,
                    Expanded(
                      child: Text(
                        promotiondetails.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                spaceH4,
                const Divider(
                  height: 3,
                  color: colorGray03,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupBuy(
    BuildContext context,
    ProductDetailState state,
    ProductDetailBloc bloc,
    DataProduct? product,
  ) async {
    PopupCreateTerminationResignation.show(
      state: state,
      bloc: bloc,
      widgetCountQuality: CountQuality(
        widget: Text(
          'Số lượng:',
          style: textTheme.titleMedium,
        ),
        initialCounter: state.currentCounter,
        onCounterChanged: (newCounter) {
          bloc.onHandleCounterChanged(newCounter);
        },
      ),
      widgetButton: BlocSelector<ProductDetailBloc, ProductDetailState, bool>(
        selector: (selector) => selector.isSoldOut,
        builder: (context, isSoldOut) {
          return Column(
            key: ObjectKey(isSoldOut), // Ensure UI updates

            children: [
              if (isSoldOut && state.currentCounter != 1) ...[
                Text('Số lượng còn lại không đủ',
                    style: textTheme.titleMedium
                        ?.copyWith(color: Theme.of(context).primaryColor)),
                spaceH8,
              ],
              AppSolidButton.medium(
                  context: context,
                  color: isSoldOut ? colorGray02 : colorPrimary,
                  disabledColor: isSoldOut ? colorGray02 : colorPrimary,
                  onPressed: isSoldOut
                      ? null
                      : () {
                          bloc.onAddItemToCart(
                              productParams:
                                  ProductParams(dataProduct: product!),
                              productId: product.id ?? '',
                              quantity: product.totalQuantity ?? 0);

                          Future.delayed(const Duration(milliseconds: 400), () {
                            context.justBack();
                          });
                        },
                  'Mua hàng'),
            ],
          );
        },
      ),
      widgetImage: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Thay đổi crossAxisAlignment
        children: [
          ClipRect(
            child: Transform.translate(
              offset: const Offset(-24, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 0.85,
                child: CachedNetworkImage(
                  imageUrl: '$domain${product?.image ?? ''}',
                  width: 60.w,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

                //  Image.network(
                //   '$domain${product?.image ?? ''}',
                //   height: 100,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          spaceW10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${product!.price?.priceStr}',
                style: textTheme.titleLarge,
              ),
              spaceH6,
              Text(
                'Kho: ${state.productStoreDefault}',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
      widgetValueSelect: WidgetValueSelect(
        bloc: bloc,
        selectedSize: state.sizeSelected,
      ),
      context,
      onReload: () {
        // bloc.onReset();
      },
    );
  }

  Widget _reviewsWidget(BuildContext context,
      {required DataProduct itemProductDetailResponse}) {
    final reviews = itemProductDetailResponse.reviews!;
    return RowContentOneColumn(
      checkIspaddingTile: true,
      title: 'Đánh giá',
      isRowTitle: true,
      widgetTile: Row(
        children: [
          spaceW12,
          Text(
            'Đánh giá',
            style: textTheme.bodyMedium?.copyWith(
              color: context.appColorScheme.colorExtendedTextBodyMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          spaceW10,
          Container(
            width: 46.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: Theme.of(context).primaryColorLight,
            ),
            padding: const EdgeInsets.all(2),
            child: Row(
              children: [
                Text(
                  '${reviews.totalReviews}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorBackgroundWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                spaceW2,
                Icon(
                  Icons.star,
                  size: 16.sp,
                  color: colorBackgroundWhite,
                ),
              ],
            ),
          ),
          spaceW10,
          Text(
            '(${reviews.totalReviews}) lượt đánh giá',
            style: textTheme.bodySmall?.copyWith(
              color: colorGray04,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      isPaddingTop: true,
      widget: Column(
        children: [
          Column(
            children: reviews.data!
                .map<Widget>(
                    (dataReviews) => _childReviewers(dataReviews: dataReviews))
                .toList(),
          ),
          reviews.totalReviews! >= 2
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          routeService.pushNamed(Routes.reviewPage,
                              arguments: WriteReviewParams(
                                  onReload: () {},
                                  itemProductDetailResponse:
                                      itemProductDetailResponse));
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            'Xem tất cả (${reviews.totalReviews})',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 14,
                            ),
                          ),
                          spaceW6,
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Theme.of(context).primaryColorLight,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : space0
        ],
      ),
    );
  }

  _childReviewers({required DataReviews dataReviews}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RatingBar.builder(
              itemSize: 16,
              initialRating: dataReviews.rating!.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              // itemPadding: const EdgeInsets.symmetric(
              //     horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).primaryColorLight,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            spaceW6,
            Text(
              dataReviews.name ?? '',
              style: textTheme.bodySmall?.copyWith(color: colorSuccess03),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('01-12-2023', style: textTheme.bodySmall),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        // Text(
        //     maxLines: 2,
        //     overflow: TextOverflow.ellipsis,
        //     dataReviews.comment ?? '',
        //     style: textTheme.bodySmall),
        // const SizedBox(
        //   height: 6,
        // ),
        Row(
          children: [
            Expanded(
              child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  dataReviews.comment ?? '',
                  style: textTheme.bodyMedium),
            ),
          ],
        ),
      ],
    );
  }
}
