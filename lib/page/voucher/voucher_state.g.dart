// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherStateCWProxy {
  VoucherState viewState(ViewState viewState);

  VoucherState errorMsg(String errorMsg);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherState(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherState call({
    ViewState? viewState,
    String? errorMsg,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVoucherState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVoucherState.copyWith.fieldName(...)`
class _$VoucherStateCWProxyImpl implements _$VoucherStateCWProxy {
  const _$VoucherStateCWProxyImpl(this._value);

  final VoucherState _value;

  @override
  VoucherState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  VoucherState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherState(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
  }) {
    return VoucherState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
    );
  }
}

extension $VoucherStateCopyWith on VoucherState {
  /// Returns a callable class that can be used as follows: `instanceOfVoucherState.copyWith(...)` or like so:`instanceOfVoucherState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherStateCWProxy get copyWith => _$VoucherStateCWProxyImpl(this);
}
