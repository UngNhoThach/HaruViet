import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_history_response.g.dart';

@JsonSerializable()
@CopyWith()
class NotificationHistoryResponse {
  @JsonKey(name: 'Id')
  int? id;

  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;

  NotificationHistoryResponse({
    this.id,
    this.title,
    this.description,
  });

  factory NotificationHistoryResponse.fromJson(Map<String, dynamic> json) {
    return _$NotificationHistoryResponseFromJson(json);
  }

  static List<NotificationHistoryResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) =>
              NotificationHistoryResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => _$NotificationHistoryResponseToJson(this);
}
