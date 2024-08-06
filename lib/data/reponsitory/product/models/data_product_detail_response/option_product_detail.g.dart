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
          ?.map((e) => Value.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'descriptions': instance.descriptions,
      'values': instance.values,
    };
