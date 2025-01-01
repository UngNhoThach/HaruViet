// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'write_review_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WriteReviewStateCWProxy {
  WriteReviewState viewState(ViewState viewState);

  WriteReviewState errorMsg(String errorMsg);

  WriteReviewState comment(String? comment);

  WriteReviewState isSuccess(bool isSuccess);

  WriteReviewState userInfoLogin(UserState? userInfoLogin);

  WriteReviewState rating(double rating);

  WriteReviewState isSubmitted(bool isSubmitted);

  WriteReviewState isLoading(bool isLoading);

  WriteReviewState messsage(String? messsage);

  WriteReviewState dataProduct(DataProduct? dataProduct);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WriteReviewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WriteReviewState(...).copyWith(id: 12, name: "My name")
  /// ````
  WriteReviewState call({
    ViewState? viewState,
    String? errorMsg,
    String? comment,
    bool? isSuccess,
    UserState? userInfoLogin,
    double? rating,
    bool? isSubmitted,
    bool? isLoading,
    String? messsage,
    DataProduct? dataProduct,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWriteReviewState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWriteReviewState.copyWith.fieldName(...)`
class _$WriteReviewStateCWProxyImpl implements _$WriteReviewStateCWProxy {
  const _$WriteReviewStateCWProxyImpl(this._value);

  final WriteReviewState _value;

  @override
  WriteReviewState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  WriteReviewState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  WriteReviewState comment(String? comment) => this(comment: comment);

  @override
  WriteReviewState isSuccess(bool isSuccess) => this(isSuccess: isSuccess);

  @override
  WriteReviewState userInfoLogin(UserState? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override
  WriteReviewState rating(double rating) => this(rating: rating);

  @override
  WriteReviewState isSubmitted(bool isSubmitted) =>
      this(isSubmitted: isSubmitted);

  @override
  WriteReviewState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  WriteReviewState messsage(String? messsage) => this(messsage: messsage);

  @override
  WriteReviewState dataProduct(DataProduct? dataProduct) =>
      this(dataProduct: dataProduct);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WriteReviewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WriteReviewState(...).copyWith(id: 12, name: "My name")
  /// ````
  WriteReviewState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? isSuccess = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? isSubmitted = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? messsage = const $CopyWithPlaceholder(),
    Object? dataProduct = const $CopyWithPlaceholder(),
  }) {
    return WriteReviewState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      isSuccess: isSuccess == const $CopyWithPlaceholder() || isSuccess == null
          ? _value.isSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSuccess as bool,
      userInfoLogin: userInfoLogin == const $CopyWithPlaceholder()
          ? _value.userInfoLogin
          // ignore: cast_nullable_to_non_nullable
          : userInfoLogin as UserState?,
      rating: rating == const $CopyWithPlaceholder() || rating == null
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as double,
      isSubmitted:
          isSubmitted == const $CopyWithPlaceholder() || isSubmitted == null
              ? _value.isSubmitted
              // ignore: cast_nullable_to_non_nullable
              : isSubmitted as bool,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      messsage: messsage == const $CopyWithPlaceholder()
          ? _value.messsage
          // ignore: cast_nullable_to_non_nullable
          : messsage as String?,
      dataProduct: dataProduct == const $CopyWithPlaceholder()
          ? _value.dataProduct
          // ignore: cast_nullable_to_non_nullable
          : dataProduct as DataProduct?,
    );
  }
}

extension $WriteReviewStateCopyWith on WriteReviewState {
  /// Returns a callable class that can be used as follows: `instanceOfWriteReviewState.copyWith(...)` or like so:`instanceOfWriteReviewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WriteReviewStateCWProxy get copyWith => _$WriteReviewStateCWProxyImpl(this);
}
