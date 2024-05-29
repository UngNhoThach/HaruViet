// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddressStateCWProxy {
  AddressState viewState(ViewState viewState);

  AddressState errorMsg(String errorMsg);

  AddressState addressDefaultId(String? addressDefaultId);

  AddressState isLoading(bool isLoading);

  AddressState listAddresses(List<DataListAddress> listAddresses);

  AddressState isSubmitSuccess(bool isSubmitSuccess);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddressState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddressState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddressState call({
    ViewState? viewState,
    String? errorMsg,
    String? addressDefaultId,
    bool? isLoading,
    List<DataListAddress>? listAddresses,
    bool? isSubmitSuccess,
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
  AddressState addressDefaultId(String? addressDefaultId) =>
      this(addressDefaultId: addressDefaultId);

  @override
  AddressState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  AddressState listAddresses(List<DataListAddress> listAddresses) =>
      this(listAddresses: listAddresses);

  @override
  AddressState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

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
    Object? addressDefaultId = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? listAddresses = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
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
      addressDefaultId: addressDefaultId == const $CopyWithPlaceholder()
          ? _value.addressDefaultId
          // ignore: cast_nullable_to_non_nullable
          : addressDefaultId as String?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      listAddresses:
          listAddresses == const $CopyWithPlaceholder() || listAddresses == null
              ? _value.listAddresses
              // ignore: cast_nullable_to_non_nullable
              : listAddresses as List<DataListAddress>,
      isSubmitSuccess: isSubmitSuccess == const $CopyWithPlaceholder() ||
              isSubmitSuccess == null
          ? _value.isSubmitSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSubmitSuccess as bool,
    );
  }
}

extension $AddressStateCopyWith on AddressState {
  /// Returns a callable class that can be used as follows: `instanceOfAddressState.copyWith(...)` or like so:`instanceOfAddressState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddressStateCWProxy get copyWith => _$AddressStateCWProxyImpl(this);
}
