import 'package:json_annotation/json_annotation.dart';

part 'data_status_order.g.dart';

@JsonSerializable()
class DataStatusOrder {
  int? id;
  String? name;

  DataStatusOrder({this.id, this.name});

  factory DataStatusOrder.fromJson(Map<String, dynamic> json) =>
      _$DataStatusOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DataStatusOrderToJson(this);
}
