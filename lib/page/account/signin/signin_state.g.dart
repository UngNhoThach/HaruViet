// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignInStateCWProxy {
  SignInState viewState(ViewState viewState);

  SignInState errorMsg(String errorMsg);

  SignInState sigupStatus(SigupStatus? sigupStatus);

  SignInState email(String? email);

  SignInState accessToken(String? accessToken);

  SignInState password(String? password);

  SignInState isLoadingButton(bool? isLoadingButton);

  SignInState verifyStatus(VerifyStatus? verifyStatus);

  SignInState isLoading(bool isLoading);

  SignInState dataLogin(DataLogin? dataLogin);

  SignInState isSubmitSuccess(bool isSubmitSuccess);

  SignInState dataUser(UserState? dataUser);

  SignInState message(String? message);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInState(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInState call({
    ViewState? viewState,
    String? errorMsg,
    SigupStatus? sigupStatus,
    String? email,
    String? accessToken,
    String? password,
    bool? isLoadingButton,
    VerifyStatus? verifyStatus,
    bool? isLoading,
    DataLogin? dataLogin,
    bool? isSubmitSuccess,
    UserState? dataUser,
    String? message,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignInState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignInState.copyWith.fieldName(...)`
class _$SignInStateCWProxyImpl implements _$SignInStateCWProxy {
  const _$SignInStateCWProxyImpl(this._value);

  final SignInState _value;

  @override
  SignInState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  SignInState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  SignInState sigupStatus(SigupStatus? sigupStatus) =>
      this(sigupStatus: sigupStatus);

  @override
  SignInState email(String? email) => this(email: email);

  @override
  SignInState accessToken(String? accessToken) =>
      this(accessToken: accessToken);

  @override
  SignInState password(String? password) => this(password: password);

  @override
  SignInState isLoadingButton(bool? isLoadingButton) =>
      this(isLoadingButton: isLoadingButton);

  @override
  SignInState verifyStatus(VerifyStatus? verifyStatus) =>
      this(verifyStatus: verifyStatus);

  @override
  SignInState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  SignInState dataLogin(DataLogin? dataLogin) => this(dataLogin: dataLogin);

  @override
  SignInState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  SignInState dataUser(UserState? dataUser) => this(dataUser: dataUser);

  @override
  SignInState message(String? message) => this(message: message);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInState(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? sigupStatus = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? isLoadingButton = const $CopyWithPlaceholder(),
    Object? verifyStatus = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? dataLogin = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? dataUser = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return SignInState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      sigupStatus: sigupStatus == const $CopyWithPlaceholder()
          ? _value.sigupStatus
          // ignore: cast_nullable_to_non_nullable
          : sigupStatus as SigupStatus?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      accessToken: accessToken == const $CopyWithPlaceholder()
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String?,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String?,
      isLoadingButton: isLoadingButton == const $CopyWithPlaceholder()
          ? _value.isLoadingButton
          // ignore: cast_nullable_to_non_nullable
          : isLoadingButton as bool?,
      verifyStatus: verifyStatus == const $CopyWithPlaceholder()
          ? _value.verifyStatus
          // ignore: cast_nullable_to_non_nullable
          : verifyStatus as VerifyStatus?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      dataLogin: dataLogin == const $CopyWithPlaceholder()
          ? _value.dataLogin
          // ignore: cast_nullable_to_non_nullable
          : dataLogin as DataLogin?,
      isSubmitSuccess: isSubmitSuccess == const $CopyWithPlaceholder() ||
              isSubmitSuccess == null
          ? _value.isSubmitSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSubmitSuccess as bool,
      dataUser: dataUser == const $CopyWithPlaceholder()
          ? _value.dataUser
          // ignore: cast_nullable_to_non_nullable
          : dataUser as UserState?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
    );
  }
}

extension $SignInStateCopyWith on SignInState {
  /// Returns a callable class that can be used as follows: `instanceOfSignInState.copyWith(...)` or like so:`instanceOfSignInState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignInStateCWProxy get copyWith => _$SignInStateCWProxyImpl(this);
}
