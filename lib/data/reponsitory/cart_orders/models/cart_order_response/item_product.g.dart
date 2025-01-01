// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemProduct _$ItemProductFromJson(Map<String, dynamic> json) => ItemProduct(
      image: json['image'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      attribute: json['attribute'],
    );

Map<String, dynamic> _$ItemProductToJson(ItemProduct instance) =>
    <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'qty': instance.qty,
      'attribute': instance.attribute,
    };
