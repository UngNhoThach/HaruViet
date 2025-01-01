import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'setting_app_state.g.dart';

@JsonSerializable()
@CopyWith()
class SettingAppState {
  @JsonKey(name: "X-Name")
  String? xName;

  @JsonKey(name: "X-ApiKey")
  String? xApiKey;

  @JsonKey(name: "X-Url")
  String? xUrl;

  @JsonKey(name: "X-Powered-By")
  String? xPoweredBy;

  String? date;

  SettingAppState({
    this.xName,
    this.xApiKey,
    this.xUrl,
    this.xPoweredBy,
    this.date,
  });
  @override
  String toString() {
    return 'X-Name: $xName,X-ApiKey: $xApiKey, X-Url: $xUrl, X-Powered-By: $xPoweredBy';
  }

  factory SettingAppState.fromJson(Map<String, dynamic> json) =>
      _$SettingAppStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingAppStateToJson(this);
}
