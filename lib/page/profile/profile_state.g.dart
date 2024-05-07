// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileStateCWProxy {
  ProfileState viewState(ViewState viewState);

  ProfileState errorMsg(String errorMsg);

  ProfileState isSubmitSuccess(bool isSubmitSuccess);

  ProfileState isLoading(bool isLoading);

  ProfileState userInfoLogin(UserInfoLogin? userInfoLogin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileState(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isSubmitSuccess,
    bool? isLoading,
    UserInfoLogin? userInfoLogin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfileState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfileState.copyWith.fieldName(...)`
class _$ProfileStateCWProxyImpl implements _$ProfileStateCWProxy {
  const _$ProfileStateCWProxyImpl(this._value);

  final ProfileState _value;

  @override
  ProfileState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  ProfileState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  ProfileState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  ProfileState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  ProfileState userInfoLogin(UserInfoLogin? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileState(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
  }) {
    return ProfileState(
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

extension $ProfileStateCopyWith on ProfileState {
  /// Returns a callable class that can be used as follows: `instanceOfProfileState.copyWith(...)` or like so:`instanceOfProfileState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProfileStateCWProxy get copyWith => _$ProfileStateCWProxyImpl(this);
}
