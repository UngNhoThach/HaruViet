import 'package:json_annotation/json_annotation.dart';

part 'data_top_brand.g.dart';

@JsonSerializable()
class DataTopBrand {
  String? id;
  String? name;
  String? image;
  String? alias;
  int? sort;

  DataTopBrand({this.id, this.name, this.image, this.alias, this.sort});

  factory DataTopBrand.fromJson(Map<String, dynamic> json) =>
      _$DataTopBrandFromJson(json);

  Map<String, dynamic> toJson() => _$DataTopBrandToJson(this);
}
