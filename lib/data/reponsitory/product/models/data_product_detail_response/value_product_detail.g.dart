// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueOptionProduct _$ValueOptionProductFromJson(Map<String, dynamic> json) =>
    ValueOptionProduct(
      id: json['id'] as String?,
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      priceType: json['price_type'] as String?,
      descriptions: json['descriptions'] as String?,
      title: json['title'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ValueOptionProductToJson(ValueOptionProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'isSelected': instance.isSelected,
      'price_type': instance.priceType,
      'title': instance.title,
      'descriptions': instance.descriptions,
      'note': instance.note,
    };
