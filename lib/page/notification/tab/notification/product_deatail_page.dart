import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/widgets.dart';
import 'package:haruviet/component/popup/alert/alert_one_button.dart';
import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:badges/badges.dart' as badges;
import 'package:haruviet/component/rowcontent/rowcontent_one_column.dart';
import 'package:haruviet/component/rowcontent/rowcontent_v1.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/product/detail/product_detail_bloc.dart';
import 'package:haruviet/page/product/detail/product_detail_state.dart';
import 'package:haruviet/page/product/detail/widgets/popup_show_option_product.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/widget_value_select.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/count_qualition.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/product_params.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/review_file.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/scoll_to_hide_bottom_bar.dart';
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
  final FocusNode _focusNode = FocusNode();
  bool isSetting = false;
  bool listenBox = false;
  //  hide bottom
  late ScrollController _hideBottomAppBarController;

  final List<Comment> commentList = [
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện'),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content:
            'Không có hình ảnh nào. Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện'),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện'),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện '),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện '),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện '),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện '),
  ];
  int length = 0;

  @override
  void initState() {
    domain = context.read<UserBloc>().state.subDomain ?? '';

    bloc = ProductDetailBloc(context)..getData(widget.params.idProduct, domain);
    _hideBottomAppBarController = ScrollController();

    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        //   bloc.onFetch(page: pageKey);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();

    _hideBottomAppBarController.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 1);

  final Map<String, dynamic>? data = {
    'Tính năng': 'Ngăn đông mềm linh hoạt 4 chế độ Optimal Fresh+',
    'Dung tích': 'Tăng 20L dung tích với công nghệ SpaceMax™',
    'Nổi bậc': 'Khử mùi với hệ thống lọc than hoạt tính',
    'Linh hoạt':
        'Với 4 chế độ làm lạnh linh hoạt giúp bạn dễ dàng chuyển đổi theo từng nhu cầu bảo quản: Chế độ "Làm mát" (phù hợp thực phẩm dùng hằng ngày như sữa, thịt nguội…); ',
  };

  final Map<String, dynamic>? dataDetail = {
    'Linh hoạt':
        'Với 4 chế độ làm lạnh linh hoạt giúp bạn dễ dàng chuyển đổi theo từng nhu cầu bảo quản: Chế độ "Làm mát" (phù hợp thực phẩm dùng hằng ngày như sữa, thịt nguội…); Chế độ "Thịt & Cá"; Chế độ "Đông mềm" (phù hợp lưu trữ thực phẩm dài ngày hơn chế độ Thịt & Cá), Chế độ "Làm lạnh nhanh" cho đồ uống. Với 4 chế độ làm lạnh linh hoạt giúp bạn dễ dàng chuyển đổi theo từng nhu cầu bảo quản: Chế độ "Làm mát" (phù hợp thực phẩm dùng hằng ngày như sữa, thịt nguội…); Chế độ "Thịt & Cá"; Chế độ "Đông mềm" (phù hợp lưu trữ thực phẩm dài ngày hơn chế độ Thịt & Cá), Chế độ "Làm lạnh nhanh" cho đồ uống.',
    'Linh kinh':
        'Với 4 chế độ làm lạnh linh hoạt giúp bạn dễ dàng chuyển đổi theo từng nhu cầu bảo quản: Chế độ "Làm mát" (phù hợp thực phẩm dùng hằng ngày như sữa, thịt nguội…); Chế độ "Thịt & Cá"; Chế độ "Đông mềm" (phù hợp lưu trữ thực phẩm dài ngày hơn chế độ Thịt & Cá), Chế độ "Làm lạnh nhanh" cho đồ uống. Với 4 chế độ làm lạnh linh hoạt giúp bạn dễ dàng chuyển đổi theo từng nhu cầu bảo quản: Chế độ "Làm mát" (phù hợp thực phẩm dùng hằng ngày như sữa, thịt nguội…); Chế độ "Thịt & Cá"; Chế độ "Đông mềm" (phù hợp lưu trữ thực phẩm dài ngày hơn chế độ Thịt & Cá), Chế độ "Làm lạnh nhanh" cho đồ uống.',
  };

  final Map<String, dynamic>? dataSupport = {
    'Linh hoạt':
        'Với lỗi trên của lái xe Q., tổ kiểm tra đã tạm giữ bằng lái 7 ngày, xử phạt hành chính 500.000 đồng. Ngoài ra lực lượng chức năng đã buộc chủ xe tháo dỡ hàng hóa cồng kềnh và yêu cầu tháo ngay chiếc xe tự chế đi kèm. ổ kiểm tra đã tạm giữ bằng lái 7 ngày, xử phạt hành chính 500.000 đồng. Ngoài ra lực lượng chức năng đã buộc chủ xe tháo dỡ hàng hóa cồng kềnh và yêu cầu tháo ngay chiếc xe tự chế đi kèm. Trao đổi với PV, Đại úy Bùi Thành Tuyên, Tổ trưởng tổ công tác cho biết, các trường hợp chở hàng cồng kềnh, quá giới hạn là một trong những nguyên nhân dẫn tới các vụ tai nạn giao thông trên đường. Tất cả các trường hợp vi phạm đều bị xử lý nghiêm theo quy định pháp luật. Tại điểm k khoản 3 Điều 6 của Nghị định 100/2019/NĐ-CP về quy định xử phạt vi phạm hành chính trong lĩnh vực giao thông đường bộ và đường sắt quy định mức phạt tiền 400.000-600.000 đồng đối với một trong các hành vi vi phạm sau đây: "Người điều khiển xe hoặc người ngồi trên xe bám, kéo, đẩy xe khác, vật khác, dẫn dắt súc vật, mang vác vật cồng kềnh; người được chở trên xe đứng trên yên, giá đèo hàng hoặc ngồi trên tay lái; xếp hàng hóa trên xe vượt quá giới hạn quy định...',
  };
  bool showAllComments = false;

  Widget _shimmer(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => ShimmerEffect(
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        separatorBuilder: (context, index) => spaceH12,
        itemCount: 10,
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
    length = commentList.length;
    final int visibleCommentsCount = showAllComments ? commentList.length : 3;

    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
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
            return GestureDetector(
              onTap: () {
                _focusNode.unfocus();
              },
              child: Scaffold(
                body: RefreshIndicator(
                  onRefresh: () async {
                    _pagingController.refresh();
                    //  bloc.onFetch(page: startPage);
                  },
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          spaceH36,
                          state.isLoading
                              ? _shimmer(context)
                              : Expanded(
                                  child: SingleChildScrollView(
                                    controller: _hideBottomAppBarController,
                                    child: Column(
                                      children: [
                                        spaceH16,
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          child: PageView.builder(
                                            itemCount: state.imageUrls.length,
                                            onPageChanged: (index) {
                                              setState(() {
                                                currentIndex = index;
                                              });
                                            },
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  // unfocus textfield
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                  ReviewFiles.show(
                                                    imageScripts: [
                                                      state
                                                              .dataProduct
                                                              ?.descriptions
                                                              ?.name ??
                                                          '',
                                                    ],
                                                    context,
                                                    filesUrl: state.imageUrls,
                                                    initIndex: index,
                                                    onDelete: (index) {
                                                      // uploader.removeFileAtValue(
                                                      //     imageFiles[index], state.domainApi);
                                                    },
                                                  );
                                                },
                                                child: Image.network(
                                                  state.imageUrls[index],
                                                  fit: BoxFit.contain,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        spaceH6,
                                        Container(
                                          color: colorGray02,
                                          padding: EdgeInsets.all(8.r),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        state.dataProduct
                                                                    ?.promotionPrice ==
                                                                null
                                                            ? '${state.dataProduct?.price?.priceStr}'
                                                            : '${state.dataProduct?.promotionPrice?.pricePromotion?.priceStr}',
                                                        style: textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  spaceH6,
                                                  Row(
                                                    children: [
                                                      state.dataProduct
                                                                  ?.promotionPrice !=
                                                              null
                                                          ? Text(
                                                              '${state.dataProduct?.price?.priceStr}',
                                                              style: textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                color:
                                                                    colorGray05,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              ),
                                                            )
                                                          : space0,
                                                      spaceW4,
                                                      state
                                                                  .dataProduct
                                                                  ?.promotionPrice
                                                                  ?.percent !=
                                                              null
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.r),
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorLight
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    '-${state.dataProduct?.promotionPrice?.percent}%',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.copyWith(
                                                                          color:
                                                                              colorBackgroundWhite,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          : space0,
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Kết thúc',
                                                        style: textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                          color: colorGray05,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      spaceW16,
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.r),
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight
                                                              .withOpacity(0.8),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '02:20:21',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                    color:
                                                                        colorBackgroundWhite,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  spaceH6,
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '95% deal đã mua',
                                                        style: textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                          color: colorGray05,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          color: colorWhite,
                                          padding: EdgeInsets.all(8.r),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    spaceH4,
                                                    Text(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      state
                                                              .dataProduct
                                                              ?.descriptions
                                                              ?.name ??
                                                          '',
                                                      //   'Tủ lạnh Samsung Inverter 599 lít Tủ lạnh Sam sung Inverter 599 lít Tủ lạnh Samsung Inverter 599 lít Tủ lạnh Samsung Inverter 599 lít',
                                                      style: textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    spaceH4,
                                                    Text(
                                                      'SKU: ${state.dataProduct?.sku ?? ''}',
                                                      style: textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                        color: colorGray03,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    spaceH6,
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Toshiba',
                                                          style: textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color: colorGray05,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    spaceH6,
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 46.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.r),
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight,
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                '4.8',
                                                                style: textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                  color:
                                                                      colorBackgroundWhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              spaceW2,
                                                              Icon(
                                                                Icons.star,
                                                                size: 16.sp,
                                                                color:
                                                                    colorBackgroundWhite,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        spaceW6,
                                                        Text(
                                                          '(120)',
                                                          style: textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color:
                                                                colorSuccess03,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        spaceW6,
                                                        Text(
                                                          'Đánh giá',
                                                          style: textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color:
                                                                colorSuccess03,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        spaceW6,
                                                        Text(
                                                          '|',
                                                          style: textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color:
                                                                colorSuccess03,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        spaceW6,
                                                        spaceW2,
                                                        Text(
                                                          '119 hỏi đáp',
                                                          style: textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color:
                                                                colorSuccess03,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    spaceW4,
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: colorGray03,
                                        ),
                                        Container(
                                            color: colorGray01,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    height: 36.h,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      border: Border.all(
                                                          color: colorGray02),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.call,
                                                          color: colorWhite,
                                                        ),
                                                        spaceW16,
                                                        const Text('Gọi điện',
                                                            style: TextStyle(
                                                                color:
                                                                    colorWhite,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      state.checkProductAttributes
                                                          ? _showPopupBuy(
                                                              context,
                                                              state,
                                                              bloc)
                                                          : bloc.onAddItemToCart(
                                                              productParams:
                                                                  ProductParams(
                                                                      dataProduct:
                                                                          state
                                                                              .dataProduct!));
                                                    },
                                                    child: Container(
                                                      height: 36.h,
                                                      decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        border: Border.all(
                                                            color: colorGray02),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .shopping_cart_checkout_sharp,
                                                            color: colorWhite,
                                                          ),
                                                          spaceW16,
                                                          const Text('Mua hàng',
                                                              style: TextStyle(
                                                                  color:
                                                                      colorWhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),

                                        const Divider(
                                          color: colorGray03,
                                        ),

                                        Container(
                                          color: colorWhite,
                                          padding: EdgeInsets.all(8.r),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .card_giftcard_sharp,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          size: 30,
                                                        ),
                                                        spaceW10,
                                                        Expanded(
                                                          child: Text(
                                                            'Tặng 2: Bông phần quà ngẫu nhiên từ nhà sản xuất tosiba',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: textTheme
                                                                .titleMedium
                                                                ?.copyWith(
                                                              color:
                                                                  colorGray05,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: colorGray03,
                                        ),
                                        Container(
                                          color: colorWhite,
                                          padding: EdgeInsets.all(8.r),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Giao nhanh miễn phí ship tại 24 tỉnh thành toàn quốc',
                                                      style: textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                        color: colorGray05,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    spaceH4,
                                                    Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.history,
                                                            color: Colors
                                                                .grey.shade500,
                                                          ),
                                                          spaceW12,
                                                          const Expanded(
                                                            child: Text(
                                                              'Bạn muốn giao hàng trước 2h ngày mai. Đặt hàng trước 6h và chọn giao hàng 2h ở dưới phần thanh toán',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.navigate_next,
                                                            color: Colors
                                                                .grey.shade500,
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
                                        const Divider(
                                          color: colorGray03,
                                        ),
                                        Container(
                                          color: colorWhite,
                                          padding: EdgeInsets.all(8.r),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          'Dung tích:',
                                                          style: textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                            color: colorGray05,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        spaceW12,
                                                        Text(
                                                          '100l',
                                                          style: textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color: colorGray05,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Spacer(
                                                          flex: 1,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.navigate_next,
                                                            color: Colors
                                                                .grey.shade500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    spaceW4,
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: colorGray03,
                                        ),
                                        spaceH6,
                                        RowContent(
                                          title: 'Thông tin sản phẩm',
                                          styleTitle:
                                              textTheme.bodyMedium?.copyWith(
                                            color: context.appColorScheme
                                                .colorExtendedTextBodyMedium,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          padding: EdgeInsets.zero,
                                          data: data,
                                        ),
                                        const Divider(
                                          color: colorGray03,
                                        ),
                                        spaceH6,
                                        RowContentOneColumn(
                                          // maxLines: 5,
                                          // isPaddingTop: true,
                                          title: 'Mô tả',
                                          styleTitle:
                                              textTheme.bodyMedium?.copyWith(
                                            color: context.appColorScheme
                                                .colorExtendedTextBodyMedium,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          padding: EdgeInsets.zero,
                                          data: dataDetail,
                                        ),
                                        const Divider(
                                          color: colorGray03,
                                        ),
                                        spaceH6,
                                        RowContentOneColumn(
                                          // maxLines: 4,
                                          // isPaddingTop: true,
                                          title: 'Hướng dẫn sử dụng',
                                          styleTitle:
                                              textTheme.bodyMedium?.copyWith(
                                            color: context.appColorScheme
                                                .colorExtendedTextBodyMedium,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          padding: EdgeInsets.zero,
                                          data: dataSupport,
                                        ),

                                        RowContentOneColumn(
                                          checkIspaddingTile: true,
                                          // maxLines: 10,
                                          title: 'Hỏi đáp',
                                          isRowTitle: true,
                                          widgetTile: Row(
                                            children: [
                                              spaceW12,
                                              Text(
                                                'Hỏi đáp (119)',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                  color: context.appColorScheme
                                                      .colorExtendedTextBodyMedium,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          isPaddingTop: true,
                                          widget: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: colorGray02)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        focusNode: _focusNode,
                                                        autofocus: false,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: null,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                "Để lại câu hỏi ...",
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 14),
                                                            border: InputBorder
                                                                .none),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.lightBlue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: const Icon(
                                                          Icons.send,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              spaceH6,
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                ),
                                                child: CommentTreeWidget<
                                                    Comment, Comment>(
                                                  Comment(
                                                      time: '30 phút trước',
                                                      avatar: 'null',
                                                      userName: 'null',
                                                      content:
                                                          'Rất đẹp và chất lượng '),
                                                  commentList.sublist(
                                                      0, visibleCommentsCount),
                                                  treeThemeData:
                                                      const TreeThemeData(
                                                          lineColor:
                                                              colorGray03,
                                                          lineWidth: 0.5),
                                                  avatarRoot: (context, data) =>
                                                      const PreferredSize(
                                                    preferredSize:
                                                        Size.fromRadius(18),
                                                    child: CircleAvatar(
                                                      radius: 18,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/education.png'),
                                                    ),
                                                  ),
                                                  avatarChild:
                                                      (context, data) =>
                                                          const PreferredSize(
                                                    preferredSize:
                                                        Size.fromRadius(12),
                                                    child: CircleAvatar(
                                                      radius: 18,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/education.png'),
                                                    ),
                                                  ),
                                                  contentChild:
                                                      (context, data) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      8),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'NGÔ THỊ THẮM',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                              spaceH4,
                                                              Text(
                                                                '${data.content}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        DefaultTextStyle(
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text('Thích'),
                                                                SizedBox(
                                                                  width: 24,
                                                                ),
                                                                Text(
                                                                    'Phản hồi'),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                  contentRoot: (context, data) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      8),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'dangngocduc',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                              spaceH4,
                                                              Text(
                                                                '${data.content}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        DefaultTextStyle(
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text('Thích'),
                                                                SizedBox(
                                                                  width: 24,
                                                                ),
                                                                Text(
                                                                    'Phản hồi'),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                              const Divider(
                                                color: colorGray03,
                                              ),
                                              (commentList.length > 3 &&
                                                      !showAllComments)
                                                  ? spaceH4
                                                  : space0,
                                              (commentList.length > 3 &&
                                                      !showAllComments)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            routeService
                                                                .pushNamed(
                                                              Routes
                                                                  .askQuesitionPage,
                                                            );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'HistoryOrderTabParams (119)',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorLight,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              spaceW6,
                                                              const Icon(
                                                                Icons
                                                                    .chevron_right_rounded,
                                                                color:
                                                                    colorPrimary,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : space0,
                                            ],
                                          ),
                                        ),

                                        // const Divider(
                                        //   color: colorGray03,
                                        // ),
                                        RowContentOneColumn(
                                          checkIspaddingTile: true,
                                          title: 'Đánh giá',
                                          isRowTitle: true,
                                          widgetTile: Row(
                                            children: [
                                              spaceW12,
                                              Text(
                                                'Đánh giá',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                  color: context.appColorScheme
                                                      .colorExtendedTextBodyMedium,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              spaceW10,
                                              Container(
                                                width: 46.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.r),
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '4.8',
                                                      style: textTheme
                                                          .bodyMedium
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
                                                      size: 16.sp,
                                                      color:
                                                          colorBackgroundWhite,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              spaceW10,
                                              Text(
                                                '(123) lượt đánh giá',
                                                style: textTheme.bodySmall
                                                    ?.copyWith(
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
                                                children: [
                                                  Row(
                                                    children: [
                                                      RatingBar.builder(
                                                        itemSize: 16,
                                                        initialRating: 3,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        // itemPadding: const EdgeInsets.symmetric(
                                                        //     horizontal: 4.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                      spaceW6,
                                                      Text(
                                                        'Phan van thanh mach',
                                                        style: textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color:
                                                                    colorSuccess03),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('01-12-2023',
                                                          style: textTheme
                                                              .bodySmall),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      'Kem dưỡng ẩm hàng ngày với khả năng làm mờ vết nhờn cung cấp bảo vệ chống nắng SPF 30, ẩm hàng ngày với khả năng làm mờ vết nhờn cung cấp bảo vệ chống nắng SPF 30,',
                                                      style:
                                                          textTheme.bodySmall),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          'Sản phẩm tốt đáng để sử dụng',
                                                          style: textTheme
                                                              .bodyMedium),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              spaceH10,
                                              const Divider(
                                                color: colorGray03,
                                              ),
                                              spaceH10,
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      RatingBar.builder(
                                                        itemSize: 16,
                                                        initialRating: 4,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        // itemPadding: const EdgeInsets.symmetric(
                                                        //     horizontal: 4.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                      spaceW6,
                                                      Text(
                                                        'Nguyen van thanh dat',
                                                        style: textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color:
                                                                    colorSuccess03),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('01-12-2023',
                                                          style: textTheme
                                                              .bodySmall),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      'Kem dưỡng ẩm hàng ngày với khả năng làm mờ vết nhờn cung cấp bảo vệ chống nắng SPF 30, ẩm hàng ngày với khả năng làm mờ vết nhờn cung cấp bảo vệ chống nắng SPF 30,',
                                                      style:
                                                          textTheme.bodySmall),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            'Sản phẩm tốt đáng để sử dụng, Sản phẩm tốt đáng để sử dụng, Sản phẩm tốt đáng để sử dụng',
                                                            style: textTheme
                                                                .bodyMedium),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              const Divider(
                                                color: colorGray03,
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        routeService.pushNamed(
                                                            Routes.reviewPage,
                                                            arguments: WriteReviewParams(
                                                                onReload: () {},
                                                                itemProductDetailResponse:
                                                                    state
                                                                        .dataProduct));
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'HistoryOrderTabParams (123)',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        spaceW6,
                                                        const Icon(
                                                          Icons
                                                              .chevron_right_rounded,
                                                          color: colorPrimary,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),

                                        spaceH72,
                                      ],
                                    ),
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
                                  showBadge:
                                      value.getCounter() == 0 ? false : true,
                                  ignorePointer: false,
                                  badgeStyle: badges.BadgeStyle(
                                      badgeColor:
                                          Theme.of(context).primaryColor),
                                  badgeContent: Text('${value.counter}'),
                                  child: IconButton(
                                    onPressed: () {
                                      routeService.pushNamed(Routes.cartPage,
                                          arguments:
                                              CartPageParams(isAppBar: true));
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
                ),
                // error when scoll this widget

                bottomNavigationBar: ScollToHideBottomBar(
                  controller: _hideBottomAppBarController,
                  child: BottomBarButton(
                    button1: AppSolidButton.medium(
                      context: context,
                      color: Theme.of(context).primaryColor,
                      'Gọi điện',
                      onPressed: () {},
                    ),
                    button2: Consumer<CartProviderV2>(
                      builder: (context, provider, child) {
                        return AppSolidButton.medium(
                          context: context,
                          color: colorPrimary,
                          'Mua hàng',
                          onPressed: () async {
                            bloc.onAddItemToCart(
                                productParams: ProductParams(
                                    dataProduct: state.dataProduct!));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showPopupBuy(
    BuildContext context,
    ProductDetailState state,
    ProductDetailBloc bloc,
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
                              productParams: ProductParams(
                                  dataProduct: state.dataProduct!));
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
                child: Image.network(
                  '$domain${state.dataProduct?.image ?? ''}',
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          spaceW10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${state.dataProduct!.price?.priceStr}',
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
}
