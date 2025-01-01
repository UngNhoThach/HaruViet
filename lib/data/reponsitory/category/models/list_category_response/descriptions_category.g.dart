// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'descriptions_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DescriptionsCategory _$DescriptionsCategoryFromJson(
        Map<String, dynamic> json) =>
    DescriptionsCategory(
      categoryId: json['category_id'] as String?,
      lang: json['lang'] as String?,
      title: json['title'] as String?,
      keyword: json['keyword'],
      description: json['description'],
    );

Map<String, dynamic> _$DescriptionsCategoryToJson(
        DescriptionsCategory instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'lang': instance.lang,
      'title': instance.title,
      'keyword': instance.keyword,
      'description': instance.description,
    };
