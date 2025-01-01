// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderDetail _$GetOrderDetailFromJson(Map<String, dynamic> json) =>
    GetOrderDetail(
      id: json['id'] as String?,
      customerId: json['customer_id'] as String?,
      subtotal: json['subtotal'] as String?,
      shipping: json['shipping'] as String?,
      discount: json['discount'] as String?,
      paymentStatus: (json['payment_status'] as num?)?.toInt(),
      shippingStatus: (json['shipping_status'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      tax: json['tax'] as String?,
      otherFee: json['other_fee'] as String?,
      total: json['total'] as String?,
      currency: json['currency'] as String?,
      exchangeRate: json['exchange_rate'] as String?,
      received: json['received'] as String?,
      balance: json['balance'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'],
      country: json['country'] as String?,
      phone: json['phone'] as String?,
      comment: json['comment'],
      paymentMethod: json['payment_method'] as String?,
      shippingMethod: json['shipping_method'] as String?,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => DetailsCart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetOrderDetailToJson(GetOrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'subtotal': instance.subtotal,
      'shipping': instance.shipping,
      'discount': instance.discount,
      'payment_status': instance.paymentStatus,
      'shipping_status': instance.shippingStatus,
      'status': instance.status,
      'tax': instance.tax,
      'other_fee': instance.otherFee,
      'total': instance.total,
      'currency': instance.currency,
      'exchange_rate': instance.exchangeRate,
      'received': instance.received,
      'balance': instance.balance,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'country': instance.country,
      'phone': instance.phone,
      'comment': instance.comment,
      'payment_method': instance.paymentMethod,
      'shipping_method': instance.shippingMethod,
      'details': instance.details,
    };
