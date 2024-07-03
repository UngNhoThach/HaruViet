// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_sate.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartStateCWProxy {
  CartState viewState(ViewState viewState);

  CartState cartItemsRequest(List<CartItemRequest> cartItemsRequest);

  CartState errorMsg(String errorMsg);

  CartState productsList(List<Products> productsList);

  CartState isSubmitSuccess(bool isSubmitSuccess);

  CartState totalItem(int? totalItem);

  CartState checkValue(bool checkValue);

  CartState isValueDefault(bool isValueDefault);

  CartState finalPrice(int? finalPrice);

  CartState finalPriceDefault(int? finalPriceDefault);

  CartState isLoading(bool isLoading);

  CartState listCategories(List<ProductResponse> listCategories);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CartState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CartState(...).copyWith(id: 12, name: "My name")
  /// ````
  CartState call({
    ViewState? viewState,
    List<CartItemRequest>? cartItemsRequest,
    String? errorMsg,
    List<Products>? productsList,
    bool? isSubmitSuccess,
    int? totalItem,
    bool? checkValue,
    bool? isValueDefault,
    int? finalPrice,
    int? finalPriceDefault,
    bool? isLoading,
    List<ProductResponse>? listCategories,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCartState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCartState.copyWith.fieldName(...)`
class _$CartStateCWProxyImpl implements _$CartStateCWProxy {
  const _$CartStateCWProxyImpl(this._value);

  final CartState _value;

  @override
  CartState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  CartState cartItemsRequest(List<CartItemRequest> cartItemsRequest) =>
      this(cartItemsRequest: cartItemsRequest);

  @override
  CartState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  CartState productsList(List<Products> productsList) =>
      this(productsList: productsList);

  @override
  CartState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  CartState totalItem(int? totalItem) => this(totalItem: totalItem);

  @override
  CartState checkValue(bool checkValue) => this(checkValue: checkValue);

  @override
  CartState isValueDefault(bool isValueDefault) =>
      this(isValueDefault: isValueDefault);

  @override
  CartState finalPrice(int? finalPrice) => this(finalPrice: finalPrice);

  @override
  CartState finalPriceDefault(int? finalPriceDefault) =>
      this(finalPriceDefault: finalPriceDefault);

  @override
  CartState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  CartState listCategories(List<ProductResponse> listCategories) =>
      this(listCategories: listCategories);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CartState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CartState(...).copyWith(id: 12, name: "My name")
  /// ````
  CartState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? cartItemsRequest = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? productsList = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? totalItem = const $CopyWithPlaceholder(),
    Object? checkValue = const $CopyWithPlaceholder(),
    Object? isValueDefault = const $CopyWithPlaceholder(),
    Object? finalPrice = const $CopyWithPlaceholder(),
    Object? finalPriceDefault = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? listCategories = const $CopyWithPlaceholder(),
  }) {
    return CartState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      cartItemsRequest: cartItemsRequest == const $CopyWithPlaceholder() ||
              cartItemsRequest == null
          ? _value.cartItemsRequest
          // ignore: cast_nullable_to_non_nullable
          : cartItemsRequest as List<CartItemRequest>,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      productsList:
          productsList == const $CopyWithPlaceholder() || productsList == null
              ? _value.productsList
              // ignore: cast_nullable_to_non_nullable
              : productsList as List<Products>,
      isSubmitSuccess: isSubmitSuccess == const $CopyWithPlaceholder() ||
              isSubmitSuccess == null
          ? _value.isSubmitSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSubmitSuccess as bool,
      totalItem: totalItem == const $CopyWithPlaceholder()
          ? _value.totalItem
          // ignore: cast_nullable_to_non_nullable
          : totalItem as int?,
      checkValue:
          checkValue == const $CopyWithPlaceholder() || checkValue == null
              ? _value.checkValue
              // ignore: cast_nullable_to_non_nullable
              : checkValue as bool,
      isValueDefault: isValueDefault == const $CopyWithPlaceholder() ||
              isValueDefault == null
          ? _value.isValueDefault
          // ignore: cast_nullable_to_non_nullable
          : isValueDefault as bool,
      finalPrice: finalPrice == const $CopyWithPlaceholder()
          ? _value.finalPrice
          // ignore: cast_nullable_to_non_nullable
          : finalPrice as int?,
      finalPriceDefault: finalPriceDefault == const $CopyWithPlaceholder()
          ? _value.finalPriceDefault
          // ignore: cast_nullable_to_non_nullable
          : finalPriceDefault as int?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      listCategories: listCategories == const $CopyWithPlaceholder() ||
              listCategories == null
          ? _value.listCategories
          // ignore: cast_nullable_to_non_nullable
          : listCategories as List<ProductResponse>,
    );
  }
}

extension $CartStateCopyWith on CartState {
  /// Returns a callable class that can be used as follows: `instanceOfCartState.copyWith(...)` or like so:`instanceOfCartState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CartStateCWProxy get copyWith => _$CartStateCWProxyImpl(this);
}
