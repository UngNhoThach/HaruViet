// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_check_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartCheckPrice _$CartCheckPriceFromJson(Map<String, dynamic> json) =>
    CartCheckPrice(
      productId: json['product_id'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      attribute: json['attribute'] == null
          ? null
          : AttributeCheckPrice.fromJson(
              json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartCheckPriceToJson(CartCheckPrice instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'qty': instance.qty,
      'attribute': instance.attribute,
    };
