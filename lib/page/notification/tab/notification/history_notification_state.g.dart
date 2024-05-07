// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_notification_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HistoryNotificationStateCWProxy {
  HistoryNotificationState viewState(ViewState viewState);

  HistoryNotificationState errorMsg(String errorMsg);

  HistoryNotificationState isSubmitSuccess(bool isSubmitSuccess);

  HistoryNotificationState isLoading(bool isLoading);

  HistoryNotificationState userInfoLogin(UserInfoLogin? userInfoLogin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HistoryNotificationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HistoryNotificationState(...).copyWith(id: 12, name: "My name")
  /// ````
  HistoryNotificationState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isSubmitSuccess,
    bool? isLoading,
    UserInfoLogin? userInfoLogin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHistoryNotificationState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHistoryNotificationState.copyWith.fieldName(...)`
class _$HistoryNotificationStateCWProxyImpl
    implements _$HistoryNotificationStateCWProxy {
  const _$HistoryNotificationStateCWProxyImpl(this._value);

  final HistoryNotificationState _value;

  @override
  HistoryNotificationState viewState(ViewState viewState) =>
      this(viewState: viewState);

  @override
  HistoryNotificationState errorMsg(String errorMsg) =>
      this(errorMsg: errorMsg);

  @override
  HistoryNotificationState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  HistoryNotificationState isLoading(bool isLoading) =>
      this(isLoading: isLoading);

  @override
  HistoryNotificationState userInfoLogin(UserInfoLogin? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HistoryNotificationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HistoryNotificationState(...).copyWith(id: 12, name: "My name")
  /// ````
  HistoryNotificationState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
  }) {
    return HistoryNotificationState(
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

extension $HistoryNotificationStateCopyWith on HistoryNotificationState {
  /// Returns a callable class that can be used as follows: `instanceOfHistoryNotificationState.copyWith(...)` or like so:`instanceOfHistoryNotificationState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HistoryNotificationStateCWProxy get copyWith =>
      _$HistoryNotificationStateCWProxyImpl(this);
}
