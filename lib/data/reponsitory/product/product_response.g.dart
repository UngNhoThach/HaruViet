// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductResponseCWProxy {
  ProductResponse id(int? id);

  ProductResponse amount(String? amount);

  ProductResponse code(String? code);

  ProductResponse image(String? image);

  ProductResponse name(String? name);

  ProductResponse price(String? price);

  ProductResponse isCheck(bool isCheck);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductResponse call({
    int? id,
    String? amount,
    String? code,
    String? image,
    String? name,
    String? price,
    bool? isCheck,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductResponse.copyWith.fieldName(...)`
class _$ProductResponseCWProxyImpl implements _$ProductResponseCWProxy {
  const _$ProductResponseCWProxyImpl(this._value);

  final ProductResponse _value;

  @override
  ProductResponse id(int? id) => this(id: id);

  @override
  ProductResponse amount(String? amount) => this(amount: amount);

  @override
  ProductResponse code(String? code) => this(code: code);

  @override
  ProductResponse image(String? image) => this(image: image);

  @override
  ProductResponse name(String? name) => this(name: name);

  @override
  ProductResponse price(String? price) => this(price: price);

  @override
  ProductResponse isCheck(bool isCheck) => this(isCheck: isCheck);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? isCheck = const $CopyWithPlaceholder(),
  }) {
    return ProductResponse(
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

extension $ProductResponseCopyWith on ProductResponse {
  /// Returns a callable class that can be used as follows: `instanceOfProductResponse.copyWith(...)` or like so:`instanceOfProductResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductResponseCWProxy get copyWith => _$ProductResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: json['Id'] as int?,
      amount: json['Amount'] as String?,
      code: json['Code'] as String?,
      image: json['Image'] as String?,
      name: json['Name'] as String?,
      price: json['Price'] as String?,
      isCheck: json['isCheck'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
      'Image': instance.image,
      'Amount': instance.amount,
      'Price': instance.price,
      'isCheck': instance.isCheck,
    };
