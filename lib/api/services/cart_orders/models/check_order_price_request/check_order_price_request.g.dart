// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_order_price_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOrderPriceRequest _$CheckOrderPriceRequestFromJson(
        Map<String, dynamic> json) =>
    CheckOrderPriceRequest(
      paymentMethod: json['paymentMethod'] as String?,
      customerUsageCount: json['customerUsageCount'] as String?,
      customerType: json['customerType'] as String?,
      inputCoupon: json['inputCoupon'] as String?,
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => CartCheckPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckOrderPriceRequestToJson(
        CheckOrderPriceRequest instance) =>
    <String, dynamic>{
      'paymentMethod': instance.paymentMethod,
      'customerUsageCount': instance.customerUsageCount,
      'customerType': instance.customerType,
      'inputCoupon': instance.inputCoupon,
      'cart': instance.cart,
    };
