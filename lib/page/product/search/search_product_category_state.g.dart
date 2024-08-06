// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product_category_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SearchProductCategoryStateCWProxy {
  SearchProductCategoryState viewState(ViewState viewState);

  SearchProductCategoryState errorMsg(String errorMsg);

  SearchProductCategoryState categorySearchList(
      List<SearchCategory> categorySearchList);

  SearchProductCategoryState isLoading(bool isLoading);

  SearchProductCategoryState checkSearch(bool checkSearch);

  SearchProductCategoryState productSearchList(
      List<SearchProduct> productSearchList);

  SearchProductCategoryState searchDataList(
      List<SuggestionDataSearchModel> searchDataList);

  SearchProductCategoryState firtTimeLoadingPage(bool firtTimeLoadingPage);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchProductCategoryState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchProductCategoryState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchProductCategoryState call({
    ViewState? viewState,
    String? errorMsg,
    List<SearchCategory>? categorySearchList,
    bool? isLoading,
    bool? checkSearch,
    List<SearchProduct>? productSearchList,
    List<SuggestionDataSearchModel>? searchDataList,
    bool? firtTimeLoadingPage,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSearchProductCategoryState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSearchProductCategoryState.copyWith.fieldName(...)`
class _$SearchProductCategoryStateCWProxyImpl
    implements _$SearchProductCategoryStateCWProxy {
  const _$SearchProductCategoryStateCWProxyImpl(this._value);

  final SearchProductCategoryState _value;

  @override
  SearchProductCategoryState viewState(ViewState viewState) =>
      this(viewState: viewState);

  @override
  SearchProductCategoryState errorMsg(String errorMsg) =>
      this(errorMsg: errorMsg);

  @override
  SearchProductCategoryState categorySearchList(
          List<SearchCategory> categorySearchList) =>
      this(categorySearchList: categorySearchList);

  @override
  SearchProductCategoryState isLoading(bool isLoading) =>
      this(isLoading: isLoading);

  @override
  SearchProductCategoryState checkSearch(bool checkSearch) =>
      this(checkSearch: checkSearch);

  @override
  SearchProductCategoryState productSearchList(
          List<SearchProduct> productSearchList) =>
      this(productSearchList: productSearchList);

  @override
  SearchProductCategoryState searchDataList(
          List<SuggestionDataSearchModel> searchDataList) =>
      this(searchDataList: searchDataList);

  @override
  SearchProductCategoryState firtTimeLoadingPage(bool firtTimeLoadingPage) =>
      this(firtTimeLoadingPage: firtTimeLoadingPage);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchProductCategoryState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchProductCategoryState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchProductCategoryState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? categorySearchList = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? checkSearch = const $CopyWithPlaceholder(),
    Object? productSearchList = const $CopyWithPlaceholder(),
    Object? searchDataList = const $CopyWithPlaceholder(),
    Object? firtTimeLoadingPage = const $CopyWithPlaceholder(),
  }) {
    return SearchProductCategoryState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      categorySearchList: categorySearchList == const $CopyWithPlaceholder() ||
              categorySearchList == null
          ? _value.categorySearchList
          // ignore: cast_nullable_to_non_nullable
          : categorySearchList as List<SearchCategory>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      checkSearch:
          checkSearch == const $CopyWithPlaceholder() || checkSearch == null
              ? _value.checkSearch
              // ignore: cast_nullable_to_non_nullable
              : checkSearch as bool,
      productSearchList: productSearchList == const $CopyWithPlaceholder() ||
              productSearchList == null
          ? _value.productSearchList
          // ignore: cast_nullable_to_non_nullable
          : productSearchList as List<SearchProduct>,
      searchDataList: searchDataList == const $CopyWithPlaceholder() ||
              searchDataList == null
          ? _value.searchDataList
          // ignore: cast_nullable_to_non_nullable
          : searchDataList as List<SuggestionDataSearchModel>,
      firtTimeLoadingPage:
          firtTimeLoadingPage == const $CopyWithPlaceholder() ||
                  firtTimeLoadingPage == null
              ? _value.firtTimeLoadingPage
              // ignore: cast_nullable_to_non_nullable
              : firtTimeLoadingPage as bool,
    );
  }
}

extension $SearchProductCategoryStateCopyWith on SearchProductCategoryState {
  /// Returns a callable class that can be used as follows: `instanceOfSearchProductCategoryState.copyWith(...)` or like so:`instanceOfSearchProductCategoryState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SearchProductCategoryStateCWProxy get copyWith =>
      _$SearchProductCategoryStateCWProxyImpl(this);
}
