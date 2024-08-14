// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtributesValue _$AtributesValueFromJson(Map<String, dynamic> json) =>
    AtributesValue(
      id: json['id'] as String?,
      lang: json['lang'] as String?,
      value: json['value'] as String?,
      isFilter: json['isFilter'] as bool?,
      idSubCategory: json['idSubCategory'] as String?,
      idSelected: json['idSelected'] as String?,
    );

Map<String, dynamic> _$AtributesValueToJson(AtributesValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lang': instance.lang,
      'value': instance.value,
      'isFilter': instance.isFilter,
      'idSubCategory': instance.idSubCategory,
      'idSelected': instance.idSelected,
    };
