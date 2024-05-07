// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CheckOutStateCWProxy {
  CheckOutState viewState(ViewState viewState);

  CheckOutState errorMsg(String errorMsg);

  CheckOutState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CheckOutState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CheckOutState(...).copyWith(id: 12, name: "My name")
  /// ````
  CheckOutState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCheckOutState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCheckOutState.copyWith.fieldName(...)`
class _$CheckOutStateCWProxyImpl implements _$CheckOutStateCWProxy {
  const _$CheckOutStateCWProxyImpl(this._value);

  final CheckOutState _value;

  @override
  CheckOutState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  CheckOutState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  CheckOutState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CheckOutState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CheckOutState(...).copyWith(id: 12, name: "My name")
  /// ````
  CheckOutState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return CheckOutState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $CheckOutStateCopyWith on CheckOutState {
  /// Returns a callable class that can be used as follows: `instanceOfCheckOutState.copyWith(...)` or like so:`instanceOfCheckOutState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CheckOutStateCWProxy get copyWith => _$CheckOutStateCWProxyImpl(this);
}
