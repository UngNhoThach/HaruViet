// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetail _$ItemDetailFromJson(Map<String, dynamic> json) => ItemDetail(
      storeId: json['store_id'] as String?,
      productId: json['product_id'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      totalPrice: (json['total_price'] as num?)?.toInt(),
      tax: (json['tax'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      currency: json['currency'] as String?,
      exchangeRate: (json['exchange_rate'] as num?)?.toInt(),
      attribute: json['attribute'] == null
          ? null
          : Attribute.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemDetailToJson(ItemDetail instance) =>
    <String, dynamic>{
      'store_id': instance.storeId,
      'product_id': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'qty': instance.qty,
      'total_price': instance.totalPrice,
      'tax': instance.tax,
      'sku': instance.sku,
      'currency': instance.currency,
      'exchange_rate': instance.exchangeRate,
      'attribute': instance.attribute,
    };
