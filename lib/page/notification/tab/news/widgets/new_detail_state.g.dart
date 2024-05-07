// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_detail_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NewDetailStateCWProxy {
  NewDetailState viewState(ViewState viewState);

  NewDetailState errorMsg(String errorMsg);

  NewDetailState isSubmitSuccess(bool isSubmitSuccess);

  NewDetailState isLoading(bool isLoading);

  NewDetailState userInfoLogin(UserInfoLogin? userInfoLogin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  NewDetailState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isSubmitSuccess,
    bool? isLoading,
    UserInfoLogin? userInfoLogin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNewDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNewDetailState.copyWith.fieldName(...)`
class _$NewDetailStateCWProxyImpl implements _$NewDetailStateCWProxy {
  const _$NewDetailStateCWProxyImpl(this._value);

  final NewDetailState _value;

  @override
  NewDetailState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  NewDetailState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  NewDetailState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  NewDetailState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  NewDetailState userInfoLogin(UserInfoLogin? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  NewDetailState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
  }) {
    return NewDetailState(
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
      userInfoLogin: userInfoLogin == const $CopyWithPlaceholder()
          ? _value.userInfoLogin
          // ignore: cast_nullable_to_non_nullable
          : userInfoLogin as UserInfoLogin?,
    );
  }
}

extension $NewDetailStateCopyWith on NewDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfNewDetailState.copyWith(...)` or like so:`instanceOfNewDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NewDetailStateCWProxy get copyWith => _$NewDetailStateCWProxyImpl(this);
}
