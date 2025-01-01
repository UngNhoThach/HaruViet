// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingsCount _$RatingsCountFromJson(Map<String, dynamic> json) => RatingsCount(
      star5: (json['5_star'] as num?)?.toInt(),
      star4: (json['4_star'] as num?)?.toInt(),
      star3: (json['3_star'] as num?)?.toInt(),
      star2: (json['2_star'] as num?)?.toInt(),
      star1: (json['1_star'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RatingsCountToJson(RatingsCount instance) =>
    <String, dynamic>{
      '5_star': instance.star5,
      '4_star': instance.star4,
      '3_star': instance.star3,
      '2_star': instance.star2,
      '1_star': instance.star1,
    };
