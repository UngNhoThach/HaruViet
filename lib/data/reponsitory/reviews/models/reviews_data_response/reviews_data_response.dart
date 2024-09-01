import 'package:json_annotation/json_annotation.dart';

part 'reviews_data_response.g.dart';

@JsonSerializable()
class ReviewsDataResponse {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<dynamic>? data;
  dynamic from;
  @JsonKey(name: 'last_page')
  int? lastPage;
  @JsonKey(name: 'per_page')
  int? perPage;
  dynamic to;
  int? total;

  ReviewsDataResponse({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory ReviewsDataResponse.fromJson(Map<String, dynamic> json) {
    return _$ReviewsDataResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewsDataResponseToJson(this);
}
