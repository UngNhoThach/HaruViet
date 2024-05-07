// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_sate.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportStateCWProxy {
  SupportState viewState(ViewState viewState);

  SupportState cartItemsRequest(List<CartItemRequest> cartItemsRequest);

  SupportState errorMsg(String errorMsg);

  SupportState totalItem(int? totalItem);

  SupportState finalPrice(int? finalPrice);

  SupportState isLoading(bool isLoading);

  SupportState listCategories(List<ProductResponse> listCategories);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SupportState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SupportState(...).copyWith(id: 12, name: "My name")
  /// ````
  SupportState call({
    ViewState? viewState,
    List<CartItemRequest>? cartItemsRequest,
    String? errorMsg,
    int? totalItem,
    int? finalPrice,
    bool? isLoading,
    List<ProductResponse>? listCategories,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSupportState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSupportState.copyWith.fieldName(...)`
class _$SupportStateCWProxyImpl implements _$SupportStateCWProxy {
  const _$SupportStateCWProxyImpl(this._value);

  final SupportState _value;

  @override
  SupportState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  SupportState cartItemsRequest(List<CartItemRequest> cartItemsRequest) =>
      this(cartItemsRequest: cartItemsRequest);

  @override
  SupportState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  SupportState totalItem(int? totalItem) => this(totalItem: totalItem);

  @override
  SupportState finalPrice(int? finalPrice) => this(finalPrice: finalPrice);

  @override
  SupportState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  SupportState listCategories(List<ProductResponse> listCategories) =>
      this(listCategories: listCategories);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SupportState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SupportState(...).copyWith(id: 12, name: "My name")
  /// ````
  SupportState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? cartItemsRequest = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? totalItem = const $CopyWithPlaceholder(),
    Object? finalPrice = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? listCategories = const $CopyWithPlaceholder(),
  }) {
    return SupportState(
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
      totalItem: totalItem == const $CopyWithPlaceholder()
          ? _value.totalItem
          // ignore: cast_nullable_to_non_nullable
          : totalItem as int?,
      finalPrice: finalPrice == const $CopyWithPlaceholder()
          ? _value.finalPrice
          // ignore: cast_nullable_to_non_nullable
          : finalPrice as int?,
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

extension $SupportStateCopyWith on SupportState {
  /// Returns a callable class that can be used as follows: `instanceOfSupportState.copyWith(...)` or like so:`instanceOfSupportState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportStateCWProxy get copyWith => _$SupportStateCWProxyImpl(this);
}
