// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsCart _$DetailsCartFromJson(Map<String, dynamic> json) => DetailsCart(
      totalProduct: (json['total_product'] as num?)?.toInt(),
      itemProduct: json['item_product'] == null
          ? null
          : ItemProduct.fromJson(json['item_product'] as Map<String, dynamic>),
      productId: json['product_id'] as String?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      totalPrice: json['total_price'] as String?,
      tax: json['tax'] as String?,
      sku: json['sku'] as String?,
      currency: json['currency'] as String?,
      exchangeRate: (json['exchange_rate'] as num?)?.toInt(),
      attribute: json['attribute'],
    );

Map<String, dynamic> _$DetailsCartToJson(DetailsCart instance) =>
    <String, dynamic>{
      'total_product': instance.totalProduct,
      'item_product': instance.itemProduct,
      'product_id': instance.productId,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'qty': instance.qty,
      'total_price': instance.totalPrice,
      'tax': instance.tax,
      'sku': instance.sku,
      'created_at': instance.createdAt,
      'currency': instance.currency,
      'exchange_rate': instance.exchangeRate,
      'attribute': instance.attribute,
    };
