// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      averageRating: (json['average_rating'] as num?)?.toInt(),
      totalReviews: (json['total_reviews'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'average_rating': instance.averageRating,
      'total_reviews': instance.totalReviews,
    };
