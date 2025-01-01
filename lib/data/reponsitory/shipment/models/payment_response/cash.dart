import 'package:json_annotation/json_annotation.dart';

part 'cash.g.dart';

@JsonSerializable()
class Cash {
  String? title;
  String? key;
  String? code;
  String? image;
  int? permission;
  String? version;
  String? auth;
  String? link;
  String? pathPlugin;

  Cash({
    this.title,
    this.key,
    this.code,
    this.image,
    this.permission,
    this.version,
    this.auth,
    this.link,
    this.pathPlugin,
  });

  factory Cash.fromJson(Map<String, dynamic> json) => _$CashFromJson(json);

  Map<String, dynamic> toJson() => _$CashToJson(this);
}
