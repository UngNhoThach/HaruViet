import 'package:json_annotation/json_annotation.dart';

part 'shipping_standard.g.dart';

@JsonSerializable()
class ShippingStandard {
  String? title;
  String? code;
  String? key;
  String? image;
  int? permission;
  int? value;
  String? version;
  String? auth;
  String? link;
  String? pathPlugin;
  List<dynamic>? store;

  ShippingStandard({
    this.title,
    this.code,
    this.key,
    this.image,
    this.permission,
    this.value,
    this.version,
    this.auth,
    this.link,
    this.pathPlugin,
    this.store,
  });

  factory ShippingStandard.fromJson(Map<String, dynamic> json) {
    return _$ShippingStandardFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShippingStandardToJson(this);
}
