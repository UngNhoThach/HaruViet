import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:haruviet/component/alert/alert_one_button.dart';
import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:badges/badges.dart' as badges;
import 'package:haruviet/component/rowcontent/rowcontent_one_column.dart';
import 'package:haruviet/component/rowcontent/rowcontent_v1.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/home/widgets/flash_deals.dart';
import 'package:haruviet/page/product/detail/product_detail_bloc.dart';
import 'package:haruviet/page/product/detail/product_detail_state.dart';
import 'package:haruviet/page/product/detail/widgets/popup_show_option_product.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/color_selector.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/count_qualition.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/review_file.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/scoll_to_hide_bottom_bar.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/size_selector.dart';
import 'package:haruviet/page/product/product_list/product_list_page.dart';
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
        bloc.onFetch(page: pageKey);
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
              color: context.appColor.colorWhite,
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

  void _showPopupAndReset(
      BuildContext context, ProductDetailState state) async {
    final result = await PopupCreateTerminationResignation.show(
      widgetCountQuality: CountQuality(
        initialCounter: state.currentCounter ?? 0,
        onCounterChanged: (newCounter) {
          bloc.onHandleCounterChanged(newCounter);
        },
      ),
      widgetButton: BlocProvider(
        create: (context) => bloc,
        child: BlocSelector<ProductDetailBloc, ProductDetailState, bool>(
          selector: (selector) {
            return selector.validBuyProductAttributes;
          },
          builder: (context, validBuyProductAttributes) {
            return AppSolidButton.medium(
                disabledColor: colorGray02,
                onPressed: validBuyProductAttributes
                    ? () {
                        bloc.onAddItemToCart(
                            quantity: state.currentCounter ?? 1,
                            idProduct: state.dataProduct?.id ?? '',
                            nameProduct:
                                state.dataProduct?.descriptions?.name ?? '',
                            brandProduct: state.dataProduct?.brand?.id ?? '',
                            imageProduct: state.dataProduct?.image ?? '',
                            priceProduct:
                                state.dataProduct!.price!.price != null
                                    ? state.dataProduct!.price!.price.toString()
                                    : '',
                            description:
                                state.dataProduct?.descriptions?.description ??
                                    '');
                      }
                    : null,
                'Mua hàng');
          },
        ),
      ),
      widgetImage: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRect(
                    child: Transform.translate(
                      offset: const Offset(-24, 0), // Dịch sang trái 24px
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.85,
                        child: Image.network(
                          '${state.imageUrls[1]}}',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          spaceW10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$ ${state.dataProduct!.price}',
                style: textTheme.titleLarge,
              ),
              spaceH6,
              Text(
                'Kho: ${state.dataProduct!.stock}',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
      widgetColor: ColorSelector(
        colors: const [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
        ],
        onColorSelected: (color) {
          bloc.onSelectColor(color.toString());
          print('Màu đã chọn: $color');
        },
      ),
      widgetSize: SizeSelector(
        sizes: const ['S', 'M', 'L', 'XL'],
        onSizeSelected: (size) {
          bloc.onSelectSize(size.toString());
          print('Size đã chọn: $size');
        },
      ),
      colorSelected: '#ec555c',
      context,
      onReload: () {
        // bloc.onReset();
      },
    );
    // This is called after the popup is closed
    bloc.onResetValiPopSelected();
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
                                                            ? '${state.dataProduct?.price?.price} \$'
                                                            : '${state.dataProduct?.promotionPrice?.pricePromotion?.priceStr}',
                                                        style: textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                color:
                                                                    colorMain,
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
                                                                color: colorMainCover1
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
                                                          color: colorMainCover1
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
                                                        color: colorMain,
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
                                                            color:
                                                                colorMainCover,
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
                                                      color: colorMain,
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
                                                          ? _showPopupAndReset(
                                                              context, state)
                                                          : bloc.onAddItemToCart(
                                                              quantity: state.currentCounter ??
                                                                  1,
                                                              idProduct: state
                                                                      .dataProduct
                                                                      ?.id ??
                                                                  '',
                                                              nameProduct: state
                                                                      .dataProduct
                                                                      ?.descriptions
                                                                      ?.name ??
                                                                  '',
                                                              brandProduct: state
                                                                      .dataProduct
                                                                      ?.brand
                                                                      ?.id ??
                                                                  '',
                                                              imageProduct: state
                                                                      .dataProduct
                                                                      ?.image ??
                                                                  '',
                                                              priceProduct:
                                                                  state.dataProduct!.price!.price != null
                                                                      ? state
                                                                          .dataProduct!
                                                                          .price!
                                                                          .price
                                                                          .toString()
                                                                      : '',
                                                              description: state.dataProduct?.descriptions?.description ?? '');
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
                                                        const Icon(
                                                          Icons
                                                              .card_giftcard_sharp,
                                                          color: colorMain,
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
                                                    //     spaceH8,
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceBetween,
                                                    //   children: [
                                                    //     Text(
                                                    //       'Số lượng:',
                                                    //       style: textTheme
                                                    //           .bodySmall
                                                    //           ?.copyWith(
                                                    //         color: colorGray05,
                                                    //         fontWeight:
                                                    //             FontWeight.w500,
                                                    //       ),
                                                    //     ),
                                                    //     Row(
                                                    //       children: [
                                                    //         GestureDetector(
                                                    //             onTap: () {
                                                    //               _decrementCounter();
                                                    //             },
                                                    //             child: const Icon(
                                                    //               Icons.remove,
                                                    //               color:
                                                    //                   colorGray05,
                                                    //             )),
                                                    //         spaceW16,
                                                    //         SizedBox(
                                                    //           width: 60,
                                                    //           height: 30,
                                                    //           child: TextField(
                                                    //             textAlign:
                                                    //                 TextAlign
                                                    //                     .center,
                                                    //             decoration:
                                                    //                 const InputDecoration(
                                                    //               border:
                                                    //                   OutlineInputBorder(),
                                                    //             ),
                                                    //             keyboardType:
                                                    //                 TextInputType
                                                    //                     .number,
                                                    //             onChanged:
                                                    //                 (newValue) {
                                                    //               if (int.tryParse(
                                                    //                       newValue) !=
                                                    //                   null) {
                                                    //                 setState(() {
                                                    //                   _counter =
                                                    //                       int.parse(
                                                    //                           newValue);
                                                    //                 });
                                                    //               }
                                                    //             },
                                                    //             controller:
                                                    //                 TextEditingController(
                                                    //                     text:
                                                    //                         ''),
                                                    //           ),
                                                    //         ),
                                                    //         spaceW16,
                                                    //         GestureDetector(
                                                    //           onTap: () {
                                                    //             _incrementCounter();
                                                    //           },
                                                    //           child: const Icon(
                                                    //             Icons.add,
                                                    //             color:
                                                    //                 colorGray05,
                                                    //           ),
                                                    //         ),
                                                    //       ],
                                                    //     ),
                                                    //     spaceH12,
                                                    //   ],
                                                    // ),

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
                                                                    .caption
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
                                                                    .caption
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
                                                              .caption!
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
                                                                    .caption!
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
                                                                    .caption!
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
                                                              .caption!
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
                                                              const Text(
                                                                'Xem tất cả (119)',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      colorPrimary,
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
                                                  color: colorMainCover,
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
                                                                const Icon(
                                                          Icons.star,
                                                          color: colorMainCover,
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
                                                                const Icon(
                                                          Icons.star,
                                                          color: colorMainCover,
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
                                                        );
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          'Xem tất cả (123)',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: colorPrimary,
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
                                        // BlocListener<ProductDetailBloc,
                                        //     ProductDetailState>(
                                        //   listenWhen: (previous, current) =>
                                        //       previous.newDataList !=
                                        //       current.newDataList,
                                        //   listener: (context, state) {
                                        //     if (state.currentPage ==
                                        //         startPage) {
                                        //       _pagingController.refresh();
                                        //     }
                                        //     if (state.canLoadMore) {
                                        //       _pagingController.appendPage(
                                        //         state.newDataList,
                                        //         state.currentPage + 1,
                                        //       );
                                        //     } else {
                                        //       _pagingController.appendLastPage(
                                        //           state.newDataList);
                                        //     }
                                        //   },
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 16),
                                        //     child: Column(
                                        //       children: [
                                        //         _topCategoriesHeader(context,
                                        //             title:
                                        //                 "Sản phẩm xem gần đây",
                                        //             isTimer: false),
                                        //         _flashDealsProductGridView(
                                        //             context),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),

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
                            Consumer<CartProvider>(
                              builder: (BuildContext context,
                                  CartProvider value, Widget? child) {
                                return badges.Badge(
                                  position: badges.BadgePosition.topEnd(
                                      top: 0, end: -8),
                                  showBadge:
                                      value.getCounter() == 0 ? false : true,
                                  ignorePointer: false,
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: colorMain),
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
                            // IconButton(
                            //   onPressed: () {
                            //     routeService.pushNamed(Routes.cartPage,
                            //         arguments: CartPageParams());
                            //   },
                            //   icon: Icon(
                            //     Icons.more_vert_sharp,
                            //     color: colorBlack,
                            //     weight: 2.5.sp,
                            //   ),
                            // ),
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
                      color: colorMain,
                      'Gọi điện',
                      onPressed: () {},
                    ),
                    button2: Consumer<CartProvider>(
                      builder: (context, provider, child) {
                        return AppSolidButton.medium(
                          color: colorPrimary,
                          'Mua hàng',
                          onPressed: () async {
                            state.checkProductAttributes
                                ? _showPopupAndReset(context, state)
                                : bloc.onAddItemToCart(
                                    quantity: state.currentCounter ?? 0,
                                    idProduct: state.dataProduct?.id ?? '',
                                    nameProduct:
                                        state.dataProduct?.descriptions?.name ??
                                            '',
                                    brandProduct:
                                        state.dataProduct?.brand?.id ?? '',
                                    imageProduct:
                                        state.dataProduct?.image ?? '',
                                    priceProduct:
                                        state.dataProduct!.price!.price != null
                                            ? state.dataProduct!.price!.price
                                                .toString()
                                            : '',
                                    description: state.dataProduct?.descriptions
                                            ?.description ??
                                        '');
                            ;
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
          isTimer ? const FlashDealsTimer() : const SizedBox(),
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
                  ?.copyWith(color: colorPrimary),
            ),
          )
        ],
      ),
    );
  }

  Widget _flashDealsProductGridView(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      slivers: [
        PagedSliverGrid(
          shrinkWrapFirstPageIndicators: true,
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          builderDelegate: PagedChildBuilderDelegate<DataProduct>(
            itemBuilder: (context, item, index) =>
                _itemFlashSale(context, index: index, data: item),
          ),
        ),
      ],
    );
  }

  Widget _itemFlashSale(BuildContext context,
      {required DataProduct data, required int index}) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            routeService.pushNamed(Routes.productDetailPage,
                arguments: ProductDetailParams(idProduct: data.id ?? ''));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: colorWhite,
              boxShadow: const [
                BoxShadow(
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
                            '$domain${data.image ?? ''}',
                            width: 75.w,
                            height: 75.h,
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
                          data.descriptions?.name ?? '',
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
        ),
      ],
    );
  }

  // Widget _flashDealsProductListView(BuildContext context) {
  //   return SizedBox(
  //     height: 280.h,
  //     child: ListView.separated(
  //       padding: EdgeInsets.symmetric(vertical: 10.h),
  //       shrinkWrap: true,
  //       physics: const BouncingScrollPhysics(),
  //       scrollDirection: Axis.horizontal,
  //       itemCount: AppData.recommendedProducts.length + 4,
  //       separatorBuilder: (_, __) => spaceW12,
  //       itemBuilder: (_, index) {
  //         return GestureDetector(
  //           onTap: () {
  //             // Navigator.push(
  //             //     context,
  //             //     MaterialPageRoute(
  //             //         builder: (builder) => const ProductDetailPage()));
  //           },
  //           child: Container(
  //             padding: EdgeInsets.symmetric(vertical: 12.h),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               boxShadow: const [
  //                 BoxShadow(
  //                   blurRadius: 4,
  //                   color: Color(0x3600000F),
  //                   offset: Offset(0, 2),
  //                 )
  //               ],
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.46,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     mainAxisSize: MainAxisSize.max,
  //                     children: [
  //                       Expanded(
  //                         child: ClipRRect(
  //                           borderRadius: BorderRadius.only(
  //                             bottomLeft: Radius.circular(0.r),
  //                             bottomRight: Radius.circular(0.r),
  //                             topLeft: Radius.circular(8.r),
  //                             topRight: Radius.circular(8.r),
  //                           ),
  //                           child: Image.network(
  //                             'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
  //                             width: 100.w,
  //                             height: 100.h,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Container(
  //                     padding:
  //                         EdgeInsets.only(top: 16.h, left: 4.w, right: 4.w),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(
  //                               '900.000 đ',
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .labelLarge
  //                                   ?.copyWith(
  //                                     color: colorMain,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                             ),
  //                             Text(
  //                               '1.200.000 đ',
  //                               style: textTheme.bodySmall?.copyWith(
  //                                 color: colorItemCover,
  //                                 fontWeight: FontWeight.bold,
  //                                 decoration: TextDecoration.lineThrough,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         spaceH4,
  //                         Text(
  //                           'Thương hiệu: Samsung',
  //                           style: textTheme.labelMedium?.copyWith(
  //                             color: colorSecondary04,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         spaceH4,
  //                         Text(
  //                           'Tủ lạnh Samsung Inverter 599 lít',
  //                           style: textTheme.labelMedium?.copyWith(
  //                             color: colorBlackTileItem,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         spaceH4,
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Row(
  //                               crossAxisAlignment: CrossAxisAlignment.center,
  //                               children: [
  //                                 Container(
  //                                   width: 42.w,
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(8.r),
  //                                     color: colorMainCover,
  //                                   ),
  //                                   padding: EdgeInsets.symmetric(
  //                                       horizontal: 4.w, vertical: 2.h),
  //                                   child: Row(
  //                                     children: [
  //                                       Text(
  //                                         '4.8',
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .labelSmall
  //                                             ?.copyWith(
  //                                               color: colorBackgroundWhite,
  //                                               fontWeight: FontWeight.w500,
  //                                             ),
  //                                       ),
  //                                       spaceW2,
  //                                       Icon(
  //                                         Icons.star,
  //                                         size: 12.sp,
  //                                         color: colorBackgroundWhite,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 spaceW2,
  //                                 Text(
  //                                   '(120)',
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .labelSmall
  //                                       ?.copyWith(
  //                                         color: colorBlueGray02,
  //                                         fontWeight: FontWeight.w500,
  //                                       ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Row(
  //                               crossAxisAlignment: CrossAxisAlignment.center,
  //                               children: [
  //                                 Icon(
  //                                   Icons.shopping_cart_outlined,
  //                                   color: colorBlueGray02,
  //                                   size: 12.sp,
  //                                 ),
  //                                 spaceW2,
  //                                 Text(
  //                                   '1.3k/tháng',
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .labelSmall
  //                                       ?.copyWith(
  //                                         color: colorBlueGray02,
  //                                         fontWeight: FontWeight.w500,
  //                                       ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                         spaceH6,
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Expanded(
  //                               child: Container(
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(8.r),
  //                                   gradient: LinearGradient(
  //                                     stops: const [0.6, 0.02],
  //                                     colors: [
  //                                       colorMainCover,
  //                                       colorMainCover.withOpacity(0.4),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: 4.w, vertical: 2.h),
  //                                 child: Text(
  //                                   'Còn: 01 : 37: 00',
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .labelSmall
  //                                       ?.copyWith(
  //                                         color: colorWhite,
  //                                         fontWeight: FontWeight.w500,
  //                                       ),
  //                                 ),
  //                               ),
  //                             ),
  //                             spaceW4,
  //                             Text(
  //                               '60%',
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .labelMedium
  //                                   ?.copyWith(color: colorMain),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
