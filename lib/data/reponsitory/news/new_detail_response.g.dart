// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_detail_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NewDetailResponseCWProxy {
  NewDetailResponse id(int? id);

  NewDetailResponse amount(String? amount);

  NewDetailResponse code(String? code);

  NewDetailResponse image(String? image);

  NewDetailResponse name(String? name);

  NewDetailResponse price(String? price);

  NewDetailResponse isCheck(bool isCheck);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewDetailResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewDetailResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NewDetailResponse call({
    int? id,
    String? amount,
    String? code,
    String? image,
    String? name,
    String? price,
    bool? isCheck,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNewDetailResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNewDetailResponse.copyWith.fieldName(...)`
class _$NewDetailResponseCWProxyImpl implements _$NewDetailResponseCWProxy {
  const _$NewDetailResponseCWProxyImpl(this._value);

  final NewDetailResponse _value;

  @override
  NewDetailResponse id(int? id) => this(id: id);

  @override
  NewDetailResponse amount(String? amount) => this(amount: amount);

  @override
  NewDetailResponse code(String? code) => this(code: code);

  @override
  NewDetailResponse image(String? image) => this(image: image);

  @override
  NewDetailResponse name(String? name) => this(name: name);

  @override
  NewDetailResponse price(String? price) => this(price: price);

  @override
  NewDetailResponse isCheck(bool isCheck) => this(isCheck: isCheck);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewDetailResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewDetailResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NewDetailResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? isCheck = const $CopyWithPlaceholder(),
  }) {
    return NewDetailResponse(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as String?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as String?,
      isCheck: isCheck == const $CopyWithPlaceholder() || isCheck == null
          ? _value.isCheck
          // ignore: cast_nullable_to_non_nullable
          : isCheck as bool,
    );
  }
}

extension $NewDetailResponseCopyWith on NewDetailResponse {
  /// Returns a callable class that can be used as follows: `instanceOfNewDetailResponse.copyWith(...)` or like so:`instanceOfNewDetailResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NewDetailResponseCWProxy get copyWith =>
      _$NewDetailResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewDetailResponse _$NewDetailResponseFromJson(Map<String, dynamic> json) =>
    NewDetailResponse(
      id: (json['Id'] as num?)?.toInt(),
      amount: json['Amount'] as String?,
      code: json['Code'] as String?,
      image: json['Image'] as String?,
      name: json['Name'] as String?,
      price: json['Price'] as String?,
      isCheck: json['isCheck'] as bool? ?? false,
    );

Map<String, dynamic> _$NewDetailResponseToJson(NewDetailResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
      'Image': instance.image,
      'Amount': instance.amount,
      'Price': instance.price,
      'isCheck': instance.isCheck,
    };
