// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListProductRequest _$GetListProductRequestFromJson(
        Map<String, dynamic> json) =>
    GetListProductRequest(
      paegNumber: (json['page[number]'] as num).toInt(),
      pageSize: (json['page[size]'] as num).toInt(),
      sort: json['sort'] as String?,
      language: json['lang'] as String?,
      category: json['category'] as String?,
      brand: json['brand'] as String?,
      filters: (json['filters'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$GetListProductRequestToJson(
        GetListProductRequest instance) =>
    <String, dynamic>{
      'page[number]': instance.paegNumber,
      'page[size]': instance.pageSize,
      'sort': instance.sort,
      'lang': instance.language,
      'category': instance.category,
      'brand': instance.brand,
      'filters': instance.filters,
    };
