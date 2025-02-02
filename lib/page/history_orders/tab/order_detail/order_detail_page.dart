import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/error/not_found_item.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_response/details_cart.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/history_orders/tab/widgets/order_detail_params.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';
import 'package:haruviet/page/review/write_review/widgets/write_review_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'order_detail_bloc.dart';
import 'order_detail_state.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderDetailParams params;
  const OrderDetailPage({
    super.key,
    required this.params,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetailPage> {
  // variables and functions
  late OrderDetailBloc bloc;
  late String domain;
  final PagingController<int, DetailsCart> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);

  Color? previousPrimaryColorColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Color primaryColorCover = Theme.of(context).primaryColor;

    if (primaryColorCover != previousPrimaryColorColor) {
      previousPrimaryColorColor = primaryColorCover;
    }
  }

  @override
  void initState() {
    super.initState();
    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
    bloc = OrderDetailBloc(params: widget.params)..getData();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onFetch(page: pageKey);
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderDetailBloc>(
      create: (_) => bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Chi tiết đơn hàng'),
        ),
        backgroundColor: const Color(0xFFECECEE),
        body: MultiBlocListener(
          listeners: [
            BlocListener<OrderDetailBloc, OrderDetailState>(
              listenWhen: (previous, current) =>
                  previous.newDataList != current.newDataList,
              listener: (context, state) {
                if (state.currentPage == startPage) {
                  _pagingController.refresh();
                }
                if (state.canLoadMore) {
                  _pagingController.appendPage(
                    state.newDataList ?? [],
                    state.currentPage + 1,
                  );
                } else {
                  _pagingController.appendLastPage(state.newDataList ?? []);
                }
              },
            ),
          ],
          child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  bloc.onReset();
                },
                child: Column(
                  children: [
                    state.newDataList == null
                        ? _shimmer(context)
                        : Expanded(
                            child: PagedListView.separated(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              pagingController: _pagingController,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding:
                                  EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 72.h),
                              builderDelegate:
                                  PagedChildBuilderDelegate<DetailsCart>(
                                noItemsFoundIndicatorBuilder: _didFoundItem,
                                itemBuilder: (context, item, index) {
                                  return _item(context,
                                      data: item, state: state);
                                },
                              ),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: colorBlueGray02,
                                thickness: 1.5,
                                height: 24,
                              ),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _item(BuildContext context,
      {required DetailsCart data, required OrderDetailState state}) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    routeService.pushNamed(Routes.writeReviewPage,
                        arguments: WriteReviewParams(
                            onReload: () {}, idItem: data.productId));
                  },
                  child: Text(
                    'Đánh giá',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ))
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: 60.w,
                  //  height: 60.h,
                  child: CachedNetworkImage(
                    fadeOutDuration: const Duration(seconds: 3),
                    imageUrl: '$domain${data.image ?? ''}',
                    width: 60.w,
                    // placeholder: (context, url) => ImageProductShimer(
                    //   width: 60.w,
                    //   height: 60.h,
                    // ), // Use the custom shimmer component
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  // ErrorInternet();
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    spaceH4,
                    _itemNameRow(name: data.name ?? ''),
                    spaceH4,
                    _itemNameRow(
                      name: toPrice(value: data.price ?? ''),
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorBlueGray03,
                      ),
                    ),
                    spaceH4,
                    _itemNameRow(
                      name: 'Thuế: ${toPrice(value: data.tax ?? '')}',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorBlueGray03),
                    ),
                    spaceH4,
                    _itemNameRow(
                      name: '${data.qty ?? ''} sản phẩm',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorBlueGray03),
                    ),
                    spaceH4,
                    _itemNameRow(
                      name:
                          'Thành tiền: ${toPrice(value: data.totalPrice ?? '')}',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 72.h),
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

  Widget _didFoundItem(BuildContext context) {
    return DidntFoundItem(
      onPressed: () {
        routeService.pushNamed(Routes.productListPage,
            arguments: ProductListPageParams());
      },
      widget: Column(
        children: [
          spaceH100,
          Text(
            'Không tìm thấy dữ liệu phù hợp',
            style: TextStyle(color: previousPrimaryColorColor),
          )
        ],
      ),
      isCartWidget: false,
    );
  }

  Widget _itemNameRow({required String name, TextStyle? style}) {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            maxLines: null,
            name,
            style: style ??
                textTheme.titleMedium?.copyWith(
                  color: colorBlack,
                ),
          ),
        ),
      ],
    );
  }
}
