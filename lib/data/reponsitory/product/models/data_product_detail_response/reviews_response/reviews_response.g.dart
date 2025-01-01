// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsResponse _$ReviewsResponseFromJson(Map<String, dynamic> json) =>
    ReviewsResponse(
      averageRating: (json['average_rating'] as num?)?.toInt(),
      totalReviews: (json['total_reviews'] as num?)?.toInt(),
      ratingsCount: json['ratings_count'] == null
          ? null
          : RatingsCount.fromJson(
              json['ratings_count'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataReviews.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsResponseToJson(ReviewsResponse instance) =>
    <String, dynamic>{
      'average_rating': instance.averageRating,
      'total_reviews': instance.totalReviews,
      'ratings_count': instance.ratingsCount,
      'data': instance.data,
    };
