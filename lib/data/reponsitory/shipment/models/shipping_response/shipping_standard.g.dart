// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_standard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingStandard _$ShippingStandardFromJson(Map<String, dynamic> json) =>
    ShippingStandard(
      title: json['title'] as String?,
      code: json['code'] as String?,
      key: json['key'] as String?,
      image: json['image'] as String?,
      permission: (json['permission'] as num?)?.toInt(),
      value: (json['value'] as num?)?.toInt(),
      version: json['version'] as String?,
      auth: json['auth'] as String?,
      link: json['link'] as String?,
      pathPlugin: json['pathPlugin'] as String?,
      store: json['store'] as List<dynamic>?,
    );

Map<String, dynamic> _$ShippingStandardToJson(ShippingStandard instance) =>
    <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'key': instance.key,
      'image': instance.image,
      'permission': instance.permission,
      'value': instance.value,
      'version': instance.version,
      'auth': instance.auth,
      'link': instance.link,
      'pathPlugin': instance.pathPlugin,
      'store': instance.store,
    };
