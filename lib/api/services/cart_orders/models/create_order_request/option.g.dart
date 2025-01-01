// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      name: json['name'] as String?,
      values: json['values'] == null
          ? null
          : Values.fromJson(json['values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'name': instance.name,
      'values': instance.values,
    };
