// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCart _$DataCartFromJson(Map<String, dynamic> json) => DataCart(
      id: json['id'] as String?,
      paymentStatus: json['payment_status'] as String?,
      shippingStatus: (json['shipping_status'] as num?)?.toInt(),
      status: json['status'] as String?,
      total: json['total'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      paymentMethod: json['payment_method'] as String?,
      shippingMethod: json['shipping_method'] as String?,
      details: json['details'] == null
          ? null
          : DetailsCart.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataCartToJson(DataCart instance) => <String, dynamic>{
      'id': instance.id,
      'payment_status': instance.paymentStatus,
      'shipping_status': instance.shippingStatus,
      'status': instance.status,
      'total': instance.total,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'payment_method': instance.paymentMethod,
      'shipping_method': instance.shippingMethod,
      'details': instance.details,
    };
