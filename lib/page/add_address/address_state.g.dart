// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddressStateCWProxy {
  AddressState viewState(ViewState viewState);

  AddressState errorMsg(String errorMsg);

  AddressState addressShipping(DataListAddress? addressShipping);

  AddressState addressDefaultId(String? addressDefaultId);

  AddressState isLoading(bool isLoading);

  AddressState idAddressShipping(String? idAddressShipping);

  AddressState listAddresses(List<DataListAddress> listAddresses);

  AddressState isShippingAddress(bool isShippingAddress);

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
    DataListAddress? addressShipping,
    String? addressDefaultId,
    bool? isLoading,
    String? idAddressShipping,
    List<DataListAddress>? listAddresses,
    bool? isShippingAddress,
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
  AddressState addressShipping(DataListAddress? addressShipping) =>
      this(addressShipping: addressShipping);

  @override
  AddressState addressDefaultId(String? addressDefaultId) =>
      this(addressDefaultId: addressDefaultId);

  @override
  AddressState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  AddressState idAddressShipping(String? idAddressShipping) =>
      this(idAddressShipping: idAddressShipping);

  @override
  AddressState listAddresses(List<DataListAddress> listAddresses) =>
      this(listAddresses: listAddresses);

  @override
  AddressState isShippingAddress(bool isShippingAddress) =>
      this(isShippingAddress: isShippingAddress);

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
    Object? addressShipping = const $CopyWithPlaceholder(),
    Object? addressDefaultId = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? idAddressShipping = const $CopyWithPlaceholder(),
    Object? listAddresses = const $CopyWithPlaceholder(),
    Object? isShippingAddress = const $CopyWithPlaceholder(),
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
      addressShipping: addressShipping == const $CopyWithPlaceholder()
          ? _value.addressShipping
          // ignore: cast_nullable_to_non_nullable
          : addressShipping as DataListAddress?,
      addressDefaultId: addressDefaultId == const $CopyWithPlaceholder()
          ? _value.addressDefaultId
          // ignore: cast_nullable_to_non_nullable
          : addressDefaultId as String?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      idAddressShipping: idAddressShipping == const $CopyWithPlaceholder()
          ? _value.idAddressShipping
          // ignore: cast_nullable_to_non_nullable
          : idAddressShipping as String?,
      listAddresses:
          listAddresses == const $CopyWithPlaceholder() || listAddresses == null
              ? _value.listAddresses
              // ignore: cast_nullable_to_non_nullable
              : listAddresses as List<DataListAddress>,
      isShippingAddress: isShippingAddress == const $CopyWithPlaceholder() ||
              isShippingAddress == null
          ? _value.isShippingAddress
          // ignore: cast_nullable_to_non_nullable
          : isShippingAddress as bool,
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
