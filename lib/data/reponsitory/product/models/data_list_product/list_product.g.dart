// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListProduct _$ListProductFromJson(Map<String, dynamic> json) => ListProduct(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$ListProductToJson(ListProduct instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'from': instance.from,
      'last_page': instance.lastPage,
      'path': instance.path,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
    };
