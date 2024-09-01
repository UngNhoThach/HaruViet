import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/error/error_internet.dart';
import 'package:haruviet/component/error/not_found_item.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_response/data_cart_response.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/review/write_review/widgets/write_review_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'history_order_tab_bloc.dart';
import 'history_order_tab_state.dart';
import 'widgets/history_order_tab_params.dart';

class HistoryOrderTab extends StatefulWidget {
  final HistoryOrderTabParms params;
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

  @override
  void initState() {
    super.initState();
    domain = context.read<UserBloc>().state.subDomain ?? '';

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
                                      data: item, state: state);
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
      {required DataCart data, required HistoryOrderTabState state}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 249, 255),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
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
                            'Vận chuyển: ${data.shippingMethod ?? ''}',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: colorBlueGray03),
                          ),
                        ),
                        InkWell(
                            onTap: () async {
                              await bloc.onGetDetailProduct(
                                  idProduct: data.id ?? '');
                              if (state.isLoadingProductDetails != true) {
                                routeService.pushNamed(Routes.writeReviewPage,
                                    arguments: WriteReviewParams(
                                        onReload: () {},
                                        itemProductDetailResponse:
                                            state.productDetail));
                              }
                            },
                            child: Text(
                              'Đánh giá',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorMain,
                              ),
                            ))
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            width: 80.w,
                            child: Image.network(
                              '$domain${data.details?.itemProduct?.image ?? ''}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const ErrorInternet();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      maxLines: null,
                                      data.details?.itemProduct?.name ?? '',
                                      style: textTheme.titleMedium?.copyWith(
                                        color: context.appColor.colorBlack,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              spaceH8,
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      maxLines: null,
                                      '${data.details?.itemProduct?.price ?? ''} VND',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorMain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${data.details?.itemProduct?.qty ?? ''} sản phẩm',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: colorBlueGray03),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Thành tiền: ',
                              style: textTheme.titleMedium
                                  ?.copyWith(color: colorBlueGray03),
                            ),
                            Text(
                              '${data.total ?? ''} VND',
                              style: textTheme.titleMedium
                                  ?.copyWith(color: colorMain),
                            ),
                          ],
                        )
                        //
                        //    Text('01-12-2023', style: textTheme.bodySmall),
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

  Widget _didFoundItem(BuildContext context) {
    return DidntFoundItem(
      widget: Column(
        children: [
          spaceH100,
          const Text(
            'Không tìm thấy dữ liệu phù hợp',
            style: TextStyle(color: colorMainCover),
          )
        ],
      ),
      isCartWidget: false,
    );
  }
}
