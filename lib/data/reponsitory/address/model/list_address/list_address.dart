import 'package:json_annotation/json_annotation.dart';

import 'data_list_address.dart';

part 'list_address.g.dart';

@JsonSerializable()
class ListAddress {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  String? message;
  List<DataListAddress>? data;

  ListAddress({this.status, this.isStatus, this.message, this.data});

  factory ListAddress.fromJson(Map<String, dynamic> json) {
    return _$ListAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListAddressToJson(this);
}
