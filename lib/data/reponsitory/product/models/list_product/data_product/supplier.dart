import 'package:json_annotation/json_annotation.dart';

part 'supplier.g.dart';

@JsonSerializable()
class Supplier {
  String? id;
  String? name;

  Supplier({this.id, this.name});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return _$SupplierFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SupplierToJson(this);
}
