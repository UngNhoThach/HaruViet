import 'package:json_annotation/json_annotation.dart';

part 'data_reviews.g.dart';

@JsonSerializable()
class DataReviews {
  String? id;
  String? comment;
  int? rating;
  String? name;
  List<dynamic>? images;

  DataReviews({this.id, this.comment, this.rating, this.name, this.images});

  factory DataReviews.fromJson(Map<String, dynamic> json) =>
      _$DataReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$DataReviewsToJson(this);
}
