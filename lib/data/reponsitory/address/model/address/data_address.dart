import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_address.g.dart';

@JsonSerializable()
class DataAddress {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  String? message;
  DataListAddress? data;

  DataAddress({this.status, this.isStatus, this.message, this.data});

  factory DataAddress.fromJson(Map<String, dynamic> json) {
    return _$DataAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataAddressToJson(this);
}
