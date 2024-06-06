// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductDetailStateCWProxy {
  ProductDetailState viewState(ViewState viewState);

  ProductDetailState errorMsg(String errorMsg);

  ProductDetailState isSubmitSuccess(bool isSubmitSuccess);

  ProductDetailState isLoading(bool isLoading);

  ProductDetailState imageUrls(List<String> imageUrls);

  ProductDetailState dataProduct(DataProduct? dataProduct);

  ProductDetailState userInfoLogin(UserInfoLogin? userInfoLogin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductDetailState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isSubmitSuccess,
    bool? isLoading,
    List<String>? imageUrls,
    DataProduct? dataProduct,
    UserInfoLogin? userInfoLogin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductDetailState.copyWith.fieldName(...)`
class _$ProductDetailStateCWProxyImpl implements _$ProductDetailStateCWProxy {
  const _$ProductDetailStateCWProxyImpl(this._value);

  final ProductDetailState _value;

  @override
  ProductDetailState viewState(ViewState viewState) =>
      this(viewState: viewState);

  @override
  ProductDetailState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  ProductDetailState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  ProductDetailState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  ProductDetailState imageUrls(List<String> imageUrls) =>
      this(imageUrls: imageUrls);

  @override
  ProductDetailState dataProduct(DataProduct? dataProduct) =>
      this(dataProduct: dataProduct);

  @override
  ProductDetailState userInfoLogin(UserInfoLogin? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductDetailState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? imageUrls = const $CopyWithPlaceholder(),
    Object? dataProduct = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
  }) {
    return ProductDetailState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      isSubmitSuccess: isSubmitSuccess == const $CopyWithPlaceholder() ||
              isSubmitSuccess == null
          ? _value.isSubmitSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSubmitSuccess as bool,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      imageUrls: imageUrls == const $CopyWithPlaceholder() || imageUrls == null
          ? _value.imageUrls
          // ignore: cast_nullable_to_non_nullable
          : imageUrls as List<String>,
      dataProduct: dataProduct == const $CopyWithPlaceholder()
          ? _value.dataProduct
          // ignore: cast_nullable_to_non_nullable
          : dataProduct as DataProduct?,
      userInfoLogin: userInfoLogin == const $CopyWithPlaceholder()
          ? _value.userInfoLogin
          // ignore: cast_nullable_to_non_nullable
          : userInfoLogin as UserInfoLogin?,
    );
  }
}

extension $ProductDetailStateCopyWith on ProductDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfProductDetailState.copyWith(...)` or like so:`instanceOfProductDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductDetailStateCWProxy get copyWith =>
      _$ProductDetailStateCWProxyImpl(this);
}
