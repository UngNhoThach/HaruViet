import 'package:json_annotation/json_annotation.dart';

part 'data_payment.g.dart';

@JsonSerializable()
class DataPayment {
  String? title;
  String? key;
  String? code;
  String? image;
  int? permission;
  String? version;
  String? auth;
  String? link;
  String? pathPlugin;
  int? value;
  List<String?>? store;

  DataPayment({
    this.store,
    this.title,
    this.key,
    this.code,
    this.image,
    this.permission,
    this.version,
    this.auth,
    this.link,
    this.pathPlugin,
    this.value,
  });

  factory DataPayment.fromJson(Map<String, dynamic> json) =>
      _$DataPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$DataPaymentToJson(this);
}
