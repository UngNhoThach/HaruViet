import 'package:json_annotation/json_annotation.dart';

import 'data_reviews.dart';
import 'ratings_count.dart';

part 'reviews_response.g.dart';

@JsonSerializable()
class ReviewsResponse {
  @JsonKey(name: 'average_rating')
  int? averageRating;
  @JsonKey(name: 'total_reviews')
  int? totalReviews;
  @JsonKey(name: 'ratings_count')
  RatingsCount? ratingsCount;
  List<DataReviews>? data;

  ReviewsResponse({
    this.averageRating,
    this.totalReviews,
    this.ratingsCount,
    this.data,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) {
    return _$ReviewsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewsResponseToJson(this);
}
