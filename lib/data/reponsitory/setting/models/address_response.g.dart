// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddressResponseCWProxy {
  AddressResponse data(List<ItemBaseResponse>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddressResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddressResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AddressResponse call({
    List<ItemBaseResponse>? data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddressResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddressResponse.copyWith.fieldName(...)`
class _$AddressResponseCWProxyImpl implements _$AddressResponseCWProxy {
  const _$AddressResponseCWProxyImpl(this._value);

  final AddressResponse _value;

  @override
  AddressResponse data(List<ItemBaseResponse>? data) => this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddressResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddressResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AddressResponse call({
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return AddressResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<ItemBaseResponse>?,
    );
  }
}

extension $AddressResponseCopyWith on AddressResponse {
  /// Returns a callable class that can be used as follows: `instanceOfAddressResponse.copyWith(...)` or like so:`instanceOfAddressResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddressResponseCWProxy get copyWith => _$AddressResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) =>
    AddressResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemBaseResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressResponseToJson(AddressResponse instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
