// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoryStateCWProxy {
  CategoryState viewState(ViewState viewState);

  CategoryState errorMsg(String errorMsg);

  CategoryState firtTimeLoadingPage(bool firtTimeLoadingPage);

  CategoryState currentTab(CurrentTab currentTab);

  CategoryState canLoadMore(bool canLoadMore);

  CategoryState limit(int limit);

  CategoryState currentPage(int currentPage);

  CategoryState isSubmitSuccess(bool isSubmitSuccess);

  CategoryState isLoading(bool isLoading);

  CategoryState userInfoLogin(UserInfoLogin? userInfoLogin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryState(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryState call({
    ViewState? viewState,
    String? errorMsg,
    bool? firtTimeLoadingPage,
    CurrentTab? currentTab,
    bool? canLoadMore,
    int? limit,
    int? currentPage,
    bool? isSubmitSuccess,
    bool? isLoading,
    UserInfoLogin? userInfoLogin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCategoryState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCategoryState.copyWith.fieldName(...)`
class _$CategoryStateCWProxyImpl implements _$CategoryStateCWProxy {
  const _$CategoryStateCWProxyImpl(this._value);

  final CategoryState _value;

  @override
  CategoryState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  CategoryState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  CategoryState firtTimeLoadingPage(bool firtTimeLoadingPage) =>
      this(firtTimeLoadingPage: firtTimeLoadingPage);

  @override
  CategoryState currentTab(CurrentTab currentTab) =>
      this(currentTab: currentTab);

  @override
  CategoryState canLoadMore(bool canLoadMore) => this(canLoadMore: canLoadMore);

  @override
  CategoryState limit(int limit) => this(limit: limit);

  @override
  CategoryState currentPage(int currentPage) => this(currentPage: currentPage);

  @override
  CategoryState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  CategoryState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  CategoryState userInfoLogin(UserInfoLogin? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryState(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? firtTimeLoadingPage = const $CopyWithPlaceholder(),
    Object? currentTab = const $CopyWithPlaceholder(),
    Object? canLoadMore = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? currentPage = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
  }) {
    return CategoryState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      firtTimeLoadingPage:
          firtTimeLoadingPage == const $CopyWithPlaceholder() ||
                  firtTimeLoadingPage == null
              ? _value.firtTimeLoadingPage
              // ignore: cast_nullable_to_non_nullable
              : firtTimeLoadingPage as bool,
      currentTab:
          currentTab == const $CopyWithPlaceholder() || currentTab == null
              ? _value.currentTab
              // ignore: cast_nullable_to_non_nullable
              : currentTab as CurrentTab,
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

extension $CategoryStateCopyWith on CategoryState {
  /// Returns a callable class that can be used as follows: `instanceOfCategoryState.copyWith(...)` or like so:`instanceOfCategoryState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoryStateCWProxy get copyWith => _$CategoryStateCWProxyImpl(this);
}
