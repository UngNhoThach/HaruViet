// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ForgetPassWordStateCWProxy {
  ForgetPassWordState viewState(ViewState viewState);

  ForgetPassWordState verifyStatus(VerifyStatus? verifyStatus);

  ForgetPassWordState errorMsg(String errorMsg);

  ForgetPassWordState message(String? message);

  ForgetPassWordState sigupType(SigupType? sigupType);

  ForgetPassWordState timeout(int? timeout);

  ForgetPassWordState errors(NormalError? errors);

  ForgetPassWordState emailChange(String? emailChange);

  ForgetPassWordState isSubmitSuccess(bool isSubmitSuccess);

  ForgetPassWordState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ForgetPassWordState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ForgetPassWordState(...).copyWith(id: 12, name: "My name")
  /// ````
  ForgetPassWordState call({
    ViewState? viewState,
    VerifyStatus? verifyStatus,
    String? errorMsg,
    String? message,
    SigupType? sigupType,
    int? timeout,
    NormalError? errors,
    String? emailChange,
    bool? isSubmitSuccess,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfForgetPassWordState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfForgetPassWordState.copyWith.fieldName(...)`
class _$ForgetPassWordStateCWProxyImpl implements _$ForgetPassWordStateCWProxy {
  const _$ForgetPassWordStateCWProxyImpl(this._value);

  final ForgetPassWordState _value;

  @override
  ForgetPassWordState viewState(ViewState viewState) =>
      this(viewState: viewState);

  @override
  ForgetPassWordState verifyStatus(VerifyStatus? verifyStatus) =>
      this(verifyStatus: verifyStatus);

  @override
  ForgetPassWordState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  ForgetPassWordState message(String? message) => this(message: message);

  @override
  ForgetPassWordState sigupType(SigupType? sigupType) =>
      this(sigupType: sigupType);

  @override
  ForgetPassWordState timeout(int? timeout) => this(timeout: timeout);

  @override
  ForgetPassWordState errors(NormalError? errors) => this(errors: errors);

  @override
  ForgetPassWordState emailChange(String? emailChange) =>
      this(emailChange: emailChange);

  @override
  ForgetPassWordState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  ForgetPassWordState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ForgetPassWordState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ForgetPassWordState(...).copyWith(id: 12, name: "My name")
  /// ````
  ForgetPassWordState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? verifyStatus = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? sigupType = const $CopyWithPlaceholder(),
    Object? timeout = const $CopyWithPlaceholder(),
    Object? errors = const $CopyWithPlaceholder(),
    Object? emailChange = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return ForgetPassWordState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      verifyStatus: verifyStatus == const $CopyWithPlaceholder()
          ? _value.verifyStatus
          // ignore: cast_nullable_to_non_nullable
          : verifyStatus as VerifyStatus?,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      sigupType: sigupType == const $CopyWithPlaceholder()
          ? _value.sigupType
          // ignore: cast_nullable_to_non_nullable
          : sigupType as SigupType?,
      timeout: timeout == const $CopyWithPlaceholder()
          ? _value.timeout
          // ignore: cast_nullable_to_non_nullable
          : timeout as int?,
      errors: errors == const $CopyWithPlaceholder()
          ? _value.errors
          // ignore: cast_nullable_to_non_nullable
          : errors as NormalError?,
      emailChange: emailChange == const $CopyWithPlaceholder()
          ? _value.emailChange
          // ignore: cast_nullable_to_non_nullable
          : emailChange as String?,
      isSubmitSuccess: isSubmitSuccess == const $CopyWithPlaceholder() ||
              isSubmitSuccess == null
          ? _value.isSubmitSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSubmitSuccess as bool,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $ForgetPassWordStateCopyWith on ForgetPassWordState {
  /// Returns a callable class that can be used as follows: `instanceOfForgetPassWordState.copyWith(...)` or like so:`instanceOfForgetPassWordState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ForgetPassWordStateCWProxy get copyWith =>
      _$ForgetPassWordStateCWProxyImpl(this);
}
