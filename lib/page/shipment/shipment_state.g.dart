// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ShipmentStateCWProxy {
  ShipmentState viewState(ViewState viewState);

  ShipmentState errorMsg(String errorMsg);

  ShipmentState shippingFee(ShipmentFee? shippingFee);

  ShipmentState shipmentResponse(ShipmentResponse? shipmentResponse);

  ShipmentState titleSelected(String? titleSelected);

  ShipmentState titleDeliverOption(List<String> titleDeliverOption);

  ShipmentState listShipmentResponse(
      List<ShipmentResponse> listShipmentResponse);

  ShipmentState deliverOption(String? deliverOption);

  ShipmentState selectedShipment(int? selectedShipment);

  ShipmentState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShipmentState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShipmentState(...).copyWith(id: 12, name: "My name")
  /// ````
  ShipmentState call({
    ViewState? viewState,
    String? errorMsg,
    ShipmentFee? shippingFee,
    ShipmentResponse? shipmentResponse,
    String? titleSelected,
    List<String>? titleDeliverOption,
    List<ShipmentResponse>? listShipmentResponse,
    String? deliverOption,
    int? selectedShipment,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfShipmentState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfShipmentState.copyWith.fieldName(...)`
class _$ShipmentStateCWProxyImpl implements _$ShipmentStateCWProxy {
  const _$ShipmentStateCWProxyImpl(this._value);

  final ShipmentState _value;

  @override
  ShipmentState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  ShipmentState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  ShipmentState shippingFee(ShipmentFee? shippingFee) =>
      this(shippingFee: shippingFee);

  @override
  ShipmentState shipmentResponse(ShipmentResponse? shipmentResponse) =>
      this(shipmentResponse: shipmentResponse);

  @override
  ShipmentState titleSelected(String? titleSelected) =>
      this(titleSelected: titleSelected);

  @override
  ShipmentState titleDeliverOption(List<String> titleDeliverOption) =>
      this(titleDeliverOption: titleDeliverOption);

  @override
  ShipmentState listShipmentResponse(
          List<ShipmentResponse> listShipmentResponse) =>
      this(listShipmentResponse: listShipmentResponse);

  @override
  ShipmentState deliverOption(String? deliverOption) =>
      this(deliverOption: deliverOption);

  @override
  ShipmentState selectedShipment(int? selectedShipment) =>
      this(selectedShipment: selectedShipment);

  @override
  ShipmentState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShipmentState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShipmentState(...).copyWith(id: 12, name: "My name")
  /// ````
  ShipmentState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? shippingFee = const $CopyWithPlaceholder(),
    Object? shipmentResponse = const $CopyWithPlaceholder(),
    Object? titleSelected = const $CopyWithPlaceholder(),
    Object? titleDeliverOption = const $CopyWithPlaceholder(),
    Object? listShipmentResponse = const $CopyWithPlaceholder(),
    Object? deliverOption = const $CopyWithPlaceholder(),
    Object? selectedShipment = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return ShipmentState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      shippingFee: shippingFee == const $CopyWithPlaceholder()
          ? _value.shippingFee
          // ignore: cast_nullable_to_non_nullable
          : shippingFee as ShipmentFee?,
      shipmentResponse: shipmentResponse == const $CopyWithPlaceholder()
          ? _value.shipmentResponse
          // ignore: cast_nullable_to_non_nullable
          : shipmentResponse as ShipmentResponse?,
      titleSelected: titleSelected == const $CopyWithPlaceholder()
          ? _value.titleSelected
          // ignore: cast_nullable_to_non_nullable
          : titleSelected as String?,
      titleDeliverOption: titleDeliverOption == const $CopyWithPlaceholder() ||
              titleDeliverOption == null
          ? _value.titleDeliverOption
          // ignore: cast_nullable_to_non_nullable
          : titleDeliverOption as List<String>,
      listShipmentResponse:
          listShipmentResponse == const $CopyWithPlaceholder() ||
                  listShipmentResponse == null
              ? _value.listShipmentResponse
              // ignore: cast_nullable_to_non_nullable
              : listShipmentResponse as List<ShipmentResponse>,
      deliverOption: deliverOption == const $CopyWithPlaceholder()
          ? _value.deliverOption
          // ignore: cast_nullable_to_non_nullable
          : deliverOption as String?,
      selectedShipment: selectedShipment == const $CopyWithPlaceholder()
          ? _value.selectedShipment
          // ignore: cast_nullable_to_non_nullable
          : selectedShipment as int?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $ShipmentStateCopyWith on ShipmentState {
  /// Returns a callable class that can be used as follows: `instanceOfShipmentState.copyWith(...)` or like so:`instanceOfShipmentState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ShipmentStateCWProxy get copyWith => _$ShipmentStateCWProxyImpl(this);
}
