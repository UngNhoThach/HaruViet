// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_products_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductsRequest _$AddProductsRequestFromJson(Map<String, dynamic> json) =>
    AddProductsRequest(
      productId: json['product_id'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      options: json['options'] == null
          ? null
          : OptionsAddProductsRequest.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddProductsRequestToJson(AddProductsRequest instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'qty': instance.qty,
      'options': instance.options,
    };
