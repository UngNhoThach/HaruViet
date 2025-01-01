// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrdersResponse _$CreateOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    CreateOrdersResponse(
      error: (json['error'] as num?)?.toInt(),
      orderId: json['orderID'] as String?,
      msg: json['msg'] as String?,
      detail: json['detail'] == null
          ? null
          : DetailCreateOrders.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrdersResponseToJson(
        CreateOrdersResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'orderID': instance.orderId,
      'msg': instance.msg,
      'detail': instance.detail,
    };
