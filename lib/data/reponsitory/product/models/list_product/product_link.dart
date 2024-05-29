import 'package:json_annotation/json_annotation.dart';

part 'product_link.g.dart';

@JsonSerializable()
class ProductLink {
  String? url;
  String? label;
  bool? active;

  ProductLink({this.url, this.label, this.active});

  factory ProductLink.fromJson(Map<String, dynamic> json) =>
      _$ProductLinkFromJson(json);

  Map<String, dynamic> toJson() => _$ProductLinkToJson(this);
}
