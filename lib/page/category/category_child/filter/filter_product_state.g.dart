// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_product_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FilterProductStateCWProxy {
  FilterProductState viewState(ViewState viewState);

  FilterProductState errorMsg(String errorMsg);

  FilterProductState checkResetFilter(bool checkResetFilter);

  FilterProductState isLoading(bool isLoading);

  FilterProductState filteredCategories(
      Map<AtributesCategoryResponse, AtributesValue>? filteredCategories);

  FilterProductState attributesSelected(
      List<AtributesValue> attributesSelected);

  FilterProductState atributesCategoryData(
      List<AtributesCategoryResponse> atributesCategoryData);

  FilterProductState userInfoLogin(UserInfoLogin? userInfoLogin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FilterProductState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FilterProductState(...).copyWith(id: 12, name: "My name")
  /// ````
  FilterProductState call({
    ViewState? viewState,
    String? errorMsg,
    bool? checkResetFilter,
    bool? isLoading,
    Map<AtributesCategoryResponse, AtributesValue>? filteredCategories,
    List<AtributesValue>? attributesSelected,
    List<AtributesCategoryResponse>? atributesCategoryData,
    UserInfoLogin? userInfoLogin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFilterProductState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFilterProductState.copyWith.fieldName(...)`
class _$FilterProductStateCWProxyImpl implements _$FilterProductStateCWProxy {
  const _$FilterProductStateCWProxyImpl(this._value);

  final FilterProductState _value;

  @override
  FilterProductState viewState(ViewState viewState) =>
      this(viewState: viewState);

  @override
  FilterProductState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  FilterProductState checkResetFilter(bool checkResetFilter) =>
      this(checkResetFilter: checkResetFilter);

  @override
  FilterProductState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  FilterProductState filteredCategories(
          Map<AtributesCategoryResponse, AtributesValue>? filteredCategories) =>
      this(filteredCategories: filteredCategories);

  @override
  FilterProductState attributesSelected(
          List<AtributesValue> attributesSelected) =>
      this(attributesSelected: attributesSelected);

  @override
  FilterProductState atributesCategoryData(
          List<AtributesCategoryResponse> atributesCategoryData) =>
      this(atributesCategoryData: atributesCategoryData);

  @override
  FilterProductState userInfoLogin(UserInfoLogin? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FilterProductState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FilterProductState(...).copyWith(id: 12, name: "My name")
  /// ````
  FilterProductState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? checkResetFilter = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? filteredCategories = const $CopyWithPlaceholder(),
    Object? attributesSelected = const $CopyWithPlaceholder(),
    Object? atributesCategoryData = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
  }) {
    return FilterProductState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      checkResetFilter: checkResetFilter == const $CopyWithPlaceholder() ||
              checkResetFilter == null
          ? _value.checkResetFilter
          // ignore: cast_nullable_to_non_nullable
          : checkResetFilter as bool,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      filteredCategories: filteredCategories == const $CopyWithPlaceholder()
          ? _value.filteredCategories
          // ignore: cast_nullable_to_non_nullable
          : filteredCategories
              as Map<AtributesCategoryResponse, AtributesValue>?,
      attributesSelected: attributesSelected == const $CopyWithPlaceholder() ||
              attributesSelected == null
          ? _value.attributesSelected
          // ignore: cast_nullable_to_non_nullable
          : attributesSelected as List<AtributesValue>,
      atributesCategoryData:
          atributesCategoryData == const $CopyWithPlaceholder() ||
                  atributesCategoryData == null
              ? _value.atributesCategoryData
              // ignore: cast_nullable_to_non_nullable
              : atributesCategoryData as List<AtributesCategoryResponse>,
      userInfoLogin: userInfoLogin == const $CopyWithPlaceholder()
          ? _value.userInfoLogin
          // ignore: cast_nullable_to_non_nullable
          : userInfoLogin as UserInfoLogin?,
    );
  }
}

extension $FilterProductStateCopyWith on FilterProductState {
  /// Returns a callable class that can be used as follows: `instanceOfFilterProductState.copyWith(...)` or like so:`instanceOfFilterProductState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FilterProductStateCWProxy get copyWith =>
      _$FilterProductStateCWProxyImpl(this);
}
