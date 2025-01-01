// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsDataResponse _$ReviewsDataResponseFromJson(Map<String, dynamic> json) =>
    ReviewsDataResponse(
      currentPage: (json['current_page'] as num?)?.toInt(),
      data: json['data'] as List<dynamic>?,
      from: json['from'],
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      to: json['to'],
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReviewsDataResponseToJson(
        ReviewsDataResponse instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'from': instance.from,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
    };
