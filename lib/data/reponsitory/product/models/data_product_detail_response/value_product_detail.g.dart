// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      id: json['id'] as String?,
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      priceType: json['price_type'] as String?,
      descriptions: json['descriptions'],
    );

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'price_type': instance.priceType,
      'descriptions': instance.descriptions,
    };
