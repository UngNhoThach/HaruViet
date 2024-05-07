import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_response.g.dart';

@JsonSerializable()
@CopyWith()
class NewsResponse {
  @JsonKey(name: 'Id')
  int? id;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'time')
  String? time;

  NewsResponse({
    this.id,
    this.title,
    this.description,
    this.location,
    this.time,
    this.image,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return _$NewsResponseFromJson(json);
  }

  static List<NewsResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) => NewsResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
