// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartOrderResponse _$GetCartOrderResponseFromJson(
        Map<String, dynamic> json) =>
    GetCartOrderResponse(
      rowId: json['rowId'] as String?,
      image: json['image'] as String?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      qty: const IntOrStringConverter().fromJson(json['qty']),
      price: (json['price'] as num?)?.toInt(),
      tax: (json['tax'] as num?)?.toInt(),
      storeId: (json['storeId'] as num?)?.toInt(),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      conditions: json['conditions'] as List<dynamic>?,
      attributes: json['attributes'] == null
          ? null
          : AttributesGetCartOrder.fromJson(
              json['attributes'] as Map<String, dynamic>),
      subtotal: (json['subtotal'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetCartOrderResponseToJson(
        GetCartOrderResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'rowId': instance.rowId,
      'message': instance.message,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'qty': const IntOrStringConverter().toJson(instance.qty),
      'price': instance.price,
      'tax': instance.tax,
      'storeId': instance.storeId,
      'options': instance.options,
      'conditions': instance.conditions,
      'attributes': instance.attributes,
      'subtotal': instance.subtotal,
      'total': instance.total,
    };
