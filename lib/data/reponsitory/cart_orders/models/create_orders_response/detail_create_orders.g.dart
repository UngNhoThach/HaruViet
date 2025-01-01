// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_create_orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailCreateOrders _$DetailCreateOrdersFromJson(Map<String, dynamic> json) =>
    DetailCreateOrders(
      subtotal: (json['subtotal'] as num?)?.toInt(),
      shipping: (json['shipping'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      received: (json['received'] as num?)?.toInt(),
      tax: (json['tax'] as num?)?.toInt(),
      paymentStatus: (json['payment_status'] as num?)?.toInt(),
      shippingStatus: (json['shipping_status'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      exchangeRate: (json['exchange_rate'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      balance: (json['balance'] as num?)?.toInt(),
      paymentMethod: json['payment_method'] as String?,
      shippingMethod: json['shipping_method'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      firstNameKana: json['first_name_kana'],
      lastNameKana: json['last_name_kana'],
      house: json['house'] as String?,
      street: json['street'] as String?,
      ward: json['ward'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      postcode: json['postcode'],
      idProvince: (json['id_province'] as num?)?.toInt(),
      idDistrict: (json['id_district'] as num?)?.toInt(),
      idWard: (json['id_ward'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      country: json['country'] as String?,
      company: json['company'],
      comment: json['comment'],
      customerId: json['customer_id'] as String?,
      domain: json['domain'] as String?,
      id: json['id'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$DetailCreateOrdersToJson(DetailCreateOrders instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'shipping': instance.shipping,
      'discount': instance.discount,
      'received': instance.received,
      'tax': instance.tax,
      'payment_status': instance.paymentStatus,
      'shipping_status': instance.shippingStatus,
      'status': instance.status,
      'currency': instance.currency,
      'exchange_rate': instance.exchangeRate,
      'total': instance.total,
      'balance': instance.balance,
      'payment_method': instance.paymentMethod,
      'shipping_method': instance.shippingMethod,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'first_name_kana': instance.firstNameKana,
      'last_name_kana': instance.lastNameKana,
      'house': instance.house,
      'street': instance.street,
      'ward': instance.ward,
      'district': instance.district,
      'province': instance.province,
      'postcode': instance.postcode,
      'id_province': instance.idProvince,
      'id_district': instance.idDistrict,
      'id_ward': instance.idWard,
      'phone': instance.phone,
      'country': instance.country,
      'company': instance.company,
      'comment': instance.comment,
      'customer_id': instance.customerId,
      'domain': instance.domain,
      'id': instance.id,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
