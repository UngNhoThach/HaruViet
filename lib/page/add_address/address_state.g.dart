// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddressStateCWProxy {
  AddressState viewState(ViewState viewState);

  AddressState errorMsg(String errorMsg);

  AddressState isLoading(bool isLoading);

  AddressState isLocationDefault(int? isLocationDefault);

  AddressState textBtnswitchState(bool textBtnswitchState);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddressState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddressState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddressState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isLoading,
    int? isLocationDefault,
    bool? textBtnswitchState,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddressState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddressState.copyWith.fieldName(...)`
class _$AddressStateCWProxyImpl implements _$AddressStateCWProxy {
  const _$AddressStateCWProxyImpl(this._value);

  final AddressState _value;

  @override
  AddressState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  AddressState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  AddressState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  AddressState isLocationDefault(int? isLocationDefault) =>
      this(isLocationDefault: isLocationDefault);

  @override
  AddressState textBtnswitchState(bool textBtnswitchState) =>
      this(textBtnswitchState: textBtnswitchState);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddressState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddressState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddressState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isLocationDefault = const $CopyWithPlaceholder(),
    Object? textBtnswitchState = const $CopyWithPlaceholder(),
  }) {
    return AddressState(
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
      isLocationDefault: isLocationDefault == const $CopyWithPlaceholder()
          ? _value.isLocationDefault
          // ignore: cast_nullable_to_non_nullable
          : isLocationDefault as int?,
      textBtnswitchState: textBtnswitchState == const $CopyWithPlaceholder() ||
              textBtnswitchState == null
          ? _value.textBtnswitchState
          // ignore: cast_nullable_to_non_nullable
          : textBtnswitchState as bool,
    );
  }
}

extension $AddressStateCopyWith on AddressState {
  /// Returns a callable class that can be used as follows: `instanceOfAddressState.copyWith(...)` or like so:`instanceOfAddressState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddressStateCWProxy get copyWith => _$AddressStateCWProxyImpl(this);
}
