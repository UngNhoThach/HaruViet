// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState viewState(ViewState viewState);

  HomeState errorMsg(String errorMsg);

  HomeState productList(ListProduct? productList);

  HomeState canLoadMore(bool canLoadMore);

  HomeState limit(int limit);

  HomeState currentPage(int currentPage);

  HomeState isSubmitSuccess(bool isSubmitSuccess);

  HomeState datatList(List<DataProduct> datatList);

  HomeState newDataList(List<DataProduct>? newDataList);

  HomeState isLoading(bool isLoading);

  HomeState userInfoLogin(UserInfoLogin? userInfoLogin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    ViewState? viewState,
    String? errorMsg,
    ListProduct? productList,
    bool? canLoadMore,
    int? limit,
    int? currentPage,
    bool? isSubmitSuccess,
    List<DataProduct>? datatList,
    List<DataProduct>? newDataList,
    bool? isLoading,
    UserInfoLogin? userInfoLogin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeState.copyWith.fieldName(...)`
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  const _$HomeStateCWProxyImpl(this._value);

  final HomeState _value;

  @override
  HomeState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  HomeState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  HomeState productList(ListProduct? productList) =>
      this(productList: productList);

  @override
  HomeState canLoadMore(bool canLoadMore) => this(canLoadMore: canLoadMore);

  @override
  HomeState limit(int limit) => this(limit: limit);

  @override
  HomeState currentPage(int currentPage) => this(currentPage: currentPage);

  @override
  HomeState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  HomeState datatList(List<DataProduct> datatList) =>
      this(datatList: datatList);

  @override
  HomeState newDataList(List<DataProduct>? newDataList) =>
      this(newDataList: newDataList);

  @override
  HomeState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  HomeState userInfoLogin(UserInfoLogin? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? productList = const $CopyWithPlaceholder(),
    Object? canLoadMore = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? currentPage = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? datatList = const $CopyWithPlaceholder(),
    Object? newDataList = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      productList: productList == const $CopyWithPlaceholder()
          ? _value.productList
          // ignore: cast_nullable_to_non_nullable
          : productList as ListProduct?,
      canLoadMore:
          canLoadMore == const $CopyWithPlaceholder() || canLoadMore == null
              ? _value.canLoadMore
              // ignore: cast_nullable_to_non_nullable
              : canLoadMore as bool,
      limit: limit == const $CopyWithPlaceholder() || limit == null
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as int,
      currentPage:
          currentPage == const $CopyWithPlaceholder() || currentPage == null
              ? _value.currentPage
              // ignore: cast_nullable_to_non_nullable
              : currentPage as int,
      isSubmitSuccess: isSubmitSuccess == const $CopyWithPlaceholder() ||
              isSubmitSuccess == null
          ? _value.isSubmitSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSubmitSuccess as bool,
      datatList: datatList == const $CopyWithPlaceholder() || datatList == null
          ? _value.datatList
          // ignore: cast_nullable_to_non_nullable
          : datatList as List<DataProduct>,
      newDataList: newDataList == const $CopyWithPlaceholder()
          ? _value.newDataList
          // ignore: cast_nullable_to_non_nullable
          : newDataList as List<DataProduct>?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      userInfoLogin: userInfoLogin == const $CopyWithPlaceholder()
          ? _value.userInfoLogin
          // ignore: cast_nullable_to_non_nullable
          : userInfoLogin as UserInfoLogin?,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class that can be used as follows: `instanceOfHomeState.copyWith(...)` or like so:`instanceOfHomeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}
