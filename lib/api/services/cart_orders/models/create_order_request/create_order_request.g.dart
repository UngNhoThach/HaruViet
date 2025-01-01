// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderRequest _$CreateOrderRequestFromJson(Map<String, dynamic> json) =>
    CreateOrderRequest(
      dataOrder: json['dataOrder'] == null
          ? null
          : DataOrder.fromJson(json['dataOrder'] as Map<String, dynamic>),
      dataTotal: (json['dataTotal'] as List<dynamic>?)
          ?.map((e) => DataTotal.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemDetail: (json['itemDetail'] as List<dynamic>?)
          ?.map((e) => ItemDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateOrderRequestToJson(CreateOrderRequest instance) =>
    <String, dynamic>{
      'dataOrder': instance.dataOrder,
      'dataTotal': instance.dataTotal,
      'itemDetail': instance.itemDetail,
    };
