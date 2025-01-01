// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentOptions _$ShipmentOptionsFromJson(Map<String, dynamic> json) =>
    ShipmentOptions(
      name: json['name'] as String?,
      title: json['title'] as String?,
      shipMoney: (json['shipMoney'] as num?)?.toInt(),
      shipMoneyText: json['shipMoneyText'] as String?,
      vatText: json['vatText'] as String?,
      desc: json['desc'] as String?,
      coupon: json['coupon'] as String?,
      maxUses: (json['maxUses'] as num?)?.toInt(),
      maxDates: (json['maxDates'] as num?)?.toInt(),
      maxDateString: json['maxDateString'] as String?,
      content: json['content'] as String?,
      activatedDate: json['activatedDate'] as String?,
      couponTitle: json['couponTitle'] as String?,
      discount: json['discount'] as String?,
    );

Map<String, dynamic> _$ShipmentOptionsToJson(ShipmentOptions instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'shipMoney': instance.shipMoney,
      'shipMoneyText': instance.shipMoneyText,
      'vatText': instance.vatText,
      'desc': instance.desc,
      'coupon': instance.coupon,
      'maxUses': instance.maxUses,
      'maxDates': instance.maxDates,
      'maxDateString': instance.maxDateString,
      'content': instance.content,
      'activatedDate': instance.activatedDate,
      'couponTitle': instance.couponTitle,
      'discount': instance.discount,
    };
