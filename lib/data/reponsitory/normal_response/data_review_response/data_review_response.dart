import 'package:json_annotation/json_annotation.dart';

part 'data_review_response.g.dart';

@JsonSerializable()
class DataReviewResponse {
  String? id;
  String? comment;
  int? rating;
  String? name;
  List<String>? images;

  DataReviewResponse({
    this.id,
    this.comment,
    this.rating,
    this.name,
    this.images,
  });

  factory DataReviewResponse.fromJson(Map<String, dynamic> json) {
    return _$DataReviewResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataReviewResponseToJson(this);
}
