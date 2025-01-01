// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      id: json['id'] as String?,
      type: json['type'] as String?,
      descriptions: json['descriptions'],
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => ValueOptionProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'descriptions': instance.descriptions,
      'title': instance.title,
      'values': instance.values,
    };
