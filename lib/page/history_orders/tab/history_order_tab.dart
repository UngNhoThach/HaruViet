import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/error/not_found_item.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_response/data_cart_response.dart';
import 'package:haruviet/gen/assets.gen.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/date_time.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/history_orders/tab/widgets/order_detail_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'history_order_tab_bloc.dart';
import 'history_order_tab_state.dart';
import 'widgets/history_order_tab_params.dart';

class HistoryOrderTab extends StatefulWidget {
  final HistoryOrderTabParams params;
  const HistoryOrderTab({
    super.key,
    required this.params,
  });

  @override
  State<HistoryOrderTab> createState() => _HistoryOrderTabState();
}

class _HistoryOrderTabState extends State<HistoryOrderTab> {
  // variables and functions
  late HistoryOrderTabBloc bloc;
  late String domain;
  final PagingController<int, DataCart> _pagingController =
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

    bloc = context.read<HistoryOrderTabBloc>()
      ..getData(
          idUser: widget.params.idUser ?? '',
          status: widget.params.status ?? 1);
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
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFECECEE),
        body: MultiBlocListener(
          listeners: [
            BlocListener<HistoryOrderTabBloc, HistoryOrderTabState>(
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
          child: BlocBuilder<HistoryOrderTabBloc, HistoryOrderTabState>(
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
                                  PagedChildBuilderDelegate<DataCart>(
                                noItemsFoundIndicatorBuilder: _didFoundItem,
                                itemBuilder: (context, item, index) {
                                  return _item(context,
                                      previousPrimaryColorColor:
                                          previousPrimaryColorColor!,
                                      data: item,
                                      state: state);
                                },
                              ),
                              separatorBuilder: (context, index) => spaceH12,
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
      {required DataCart data,
      required HistoryOrderTabState state,
      required Color previousPrimaryColorColor}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: previousPrimaryColorColor,
          ),
          color: const Color.fromARGB(255, 248, 249, 255),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // routeService.pushNamed(
                  //   Routes.newDetailPage,
                  // );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Sản phẩm đã mua (${data.details?.totalProduct})',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: colorBlueGray03),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              routeService.pushNamed(Routes.orderDetailPage,
                                  arguments: OrderDetailParams(
                                    // not done
                                    //       isReview: ,
                                    idOrder: data.id ?? '',
                                  ));
                            },
                            child: Text(
                              'xem chi tiết',
                              style: textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ))
                      ],
                    ),
                    spaceH4,
                    const Divider(
                      height: 1,
                    ),

                    // item here
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: previousPrimaryColorColor.withOpacity(0.01),
                          borderRadius:
                              BorderRadius.circular(8.0), // Tạo bo góc cho item
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _rowItem(
                              value: data.details?.itemProduct?.name ?? '',
                            ),
                            spaceH4,
                            _rowItem(
                              value: toPrice(
                                  value:
                                      data.details?.itemProduct?.price ?? ''),
                              style: textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            spaceH4,
                            _rowItem(
                              value: data.shippingMethod ?? '',
                              widget: Assets.icons.shipmentMethod.image(
                                  height: 18,
                                  width: 18,
                                  color: colorBlueGray03),
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: colorBlueGray03),
                            ),
                            spaceH4,
                            _rowItem(
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorBlueGray03,
                              ),
                              value: converDateToString(
                                  data.details?.createdAt ?? ''),
                              widget: Assets.icons.time.image(
                                  height: 18,
                                  width: 18,
                                  color: colorBlueGray03),
                            ),
                          ],
                        )),

                    const Divider(
                      height: 1,
                    ),
                    spaceH4,

                    Row(
                      children: [
                        _subExpand(
                          name: data.paymentMethod ?? '',
                          widget: Assets.icons.paymentMethod.image(
                              height: 16, width: 16, color: colorSuccess03),
                        ),
                        Row(
                          children: [
                            Text(
                              'Tổng tiền: ',
                              style: textTheme.titleMedium
                                  ?.copyWith(color: colorBlueGray03),
                            ),
                            Text(
                              toPrice(value: data.total ?? ''),
                              style: textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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

  Widget _rowItem({
    required String value,
    Widget? widget,
    TextStyle? style,
  }) {
    return Row(
      children: [
        widget ?? space0,
        widget != null ? spaceW6 : space0,
        Flexible(
          child: Text(
            value,
            style: style ?? textTheme.bodyLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _subExpand(
      {required String name,
      Widget? widget,
      String? time,
      MainAxisAlignment? mainAxisAlignment}) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              widget ?? space0,
              spaceW4,
              Flexible(
                child: Text(
                  name,
                  style: textTheme.bodyMedium?.copyWith(color: colorSuccess03),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          time == null
              ? space0
              : Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Row(
                    mainAxisAlignment:
                        mainAxisAlignment ?? MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.av_timer_sharp,
                        size: 20,
                        color: colorSuccess03,
                      ),
                      spaceW2,
                      Flexible(
                        child: Text(
                          time,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: colorSuccess03),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget _didFoundItem(
    BuildContext context,
  ) {
    return DidntFoundItem(
      widget: Column(
        children: [
          spaceH100,
          Text(
            'Không tìm thấy dữ liệu phù hợp',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          )
        ],
      ),
      isCartWidget: false,
    );
  }
}
