// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cash _$CashFromJson(Map<String, dynamic> json) => Cash(
      title: json['title'] as String?,
      key: json['key'] as String?,
      code: json['code'] as String?,
      image: json['image'] as String?,
      permission: (json['permission'] as num?)?.toInt(),
      version: json['version'] as String?,
      auth: json['auth'] as String?,
      link: json['link'] as String?,
      pathPlugin: json['pathPlugin'] as String?,
    );

Map<String, dynamic> _$CashToJson(Cash instance) => <String, dynamic>{
      'title': instance.title,
      'key': instance.key,
      'code': instance.code,
      'image': instance.image,
      'permission': instance.permission,
      'version': instance.version,
      'auth': instance.auth,
      'link': instance.link,
      'pathPlugin': instance.pathPlugin,
    };
