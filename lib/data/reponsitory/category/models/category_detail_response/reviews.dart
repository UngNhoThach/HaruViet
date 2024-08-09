import 'package:json_annotation/json_annotation.dart';

part 'reviews.g.dart';

@JsonSerializable()
class Reviews {
  @JsonKey(name: 'average_rating')
  int? averageRating;
  @JsonKey(name: 'total_reviews')
  int? totalReviews;

  Reviews({this.averageRating, this.totalReviews});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return _$ReviewsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}
