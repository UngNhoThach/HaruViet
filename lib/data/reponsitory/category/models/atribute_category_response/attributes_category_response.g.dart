// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtributesCategoryResponse _$AtributesCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    AtributesCategoryResponse(
      id: json['id'] as String?,
      slug: json['slug'] as String?,
      descriptions: json['descriptions'] == null
          ? null
          : AtributesDescriptions.fromJson(
              json['descriptions'] as Map<String, dynamic>),
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => AtributesValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AtributesCategoryResponseToJson(
        AtributesCategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'descriptions': instance.descriptions,
      'values': instance.values,
    };
