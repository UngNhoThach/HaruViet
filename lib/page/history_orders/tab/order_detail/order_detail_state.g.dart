// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderDetailStateCWProxy {
  OrderDetailState viewState(ViewState viewState);

  OrderDetailState errorMsg(String errorMsg);

  OrderDetailState tab(int tab);

  OrderDetailState newDataList(List<DetailsCart>? newDataList);

  OrderDetailState idUser(String? idUser);

  OrderDetailState orderDetail(GetOrderDetail? orderDetail);

  OrderDetailState isLoadingProductDetails(bool isLoadingProductDetails);

  OrderDetailState currentPage(int currentPage);

  OrderDetailState limit(int limit);

  OrderDetailState canLoadMore(bool canLoadMore);

  OrderDetailState status(int? status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderDetailState call({
    ViewState? viewState,
    String? errorMsg,
    int? tab,
    List<DetailsCart>? newDataList,
    String? idUser,
    GetOrderDetail? orderDetail,
    bool? isLoadingProductDetails,
    int? currentPage,
    int? limit,
    bool? canLoadMore,
    int? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderDetailState.copyWith.fieldName(...)`
class _$OrderDetailStateCWProxyImpl implements _$OrderDetailStateCWProxy {
  const _$OrderDetailStateCWProxyImpl(this._value);

  final OrderDetailState _value;

  @override
  OrderDetailState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  OrderDetailState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  OrderDetailState tab(int tab) => this(tab: tab);

  @override
  OrderDetailState newDataList(List<DetailsCart>? newDataList) =>
      this(newDataList: newDataList);

  @override
  OrderDetailState idUser(String? idUser) => this(idUser: idUser);

  @override
  OrderDetailState orderDetail(GetOrderDetail? orderDetail) =>
      this(orderDetail: orderDetail);

  @override
  OrderDetailState isLoadingProductDetails(bool isLoadingProductDetails) =>
      this(isLoadingProductDetails: isLoadingProductDetails);

  @override
  OrderDetailState currentPage(int currentPage) =>
      this(currentPage: currentPage);

  @override
  OrderDetailState limit(int limit) => this(limit: limit);

  @override
  OrderDetailState canLoadMore(bool canLoadMore) =>
      this(canLoadMore: canLoadMore);

  @override
  OrderDetailState status(int? status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderDetailState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? tab = const $CopyWithPlaceholder(),
    Object? newDataList = const $CopyWithPlaceholder(),
    Object? idUser = const $CopyWithPlaceholder(),
    Object? orderDetail = const $CopyWithPlaceholder(),
    Object? isLoadingProductDetails = const $CopyWithPlaceholder(),
    Object? currentPage = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? canLoadMore = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return OrderDetailState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      tab: tab == const $CopyWithPlaceholder() || tab == null
          ? _value.tab
          // ignore: cast_nullable_to_non_nullable
          : tab as int,
      newDataList: newDataList == const $CopyWithPlaceholder()
          ? _value.newDataList
          // ignore: cast_nullable_to_non_nullable
          : newDataList as List<DetailsCart>?,
      idUser: idUser == const $CopyWithPlaceholder()
          ? _value.idUser
          // ignore: cast_nullable_to_non_nullable
          : idUser as String?,
      orderDetail: orderDetail == const $CopyWithPlaceholder()
          ? _value.orderDetail
          // ignore: cast_nullable_to_non_nullable
          : orderDetail as GetOrderDetail?,
      isLoadingProductDetails:
          isLoadingProductDetails == const $CopyWithPlaceholder() ||
                  isLoadingProductDetails == null
              ? _value.isLoadingProductDetails
              // ignore: cast_nullable_to_non_nullable
              : isLoadingProductDetails as bool,
      currentPage:
          currentPage == const $CopyWithPlaceholder() || currentPage == null
              ? _value.currentPage
              // ignore: cast_nullable_to_non_nullable
              : currentPage as int,
      limit: limit == const $CopyWithPlaceholder() || limit == null
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as int,
      canLoadMore:
          canLoadMore == const $CopyWithPlaceholder() || canLoadMore == null
              ? _value.canLoadMore
              // ignore: cast_nullable_to_non_nullable
              : canLoadMore as bool,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as int?,
    );
  }
}

extension $OrderDetailStateCopyWith on OrderDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfOrderDetailState.copyWith(...)` or like so:`instanceOfOrderDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderDetailStateCWProxy get copyWith => _$OrderDetailStateCWProxyImpl(this);
}
