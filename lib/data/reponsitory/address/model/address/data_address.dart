import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_address.g.dart';

@JsonSerializable()
class DataAddress {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  String? message;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  dynamic data;

  DataAddress({this.status, this.isStatus, this.message, this.data});

  factory DataAddress.fromJson(Map<String, dynamic> json) {
    return _$DataAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataAddressToJson(this);

  static dynamic _fromJson(dynamic json) {
    if (json == null) {
      return null;
    } else if (json is String) {
      return json;
    } else if (json is Map<String, dynamic>) {
      return DataListAddress.fromJson(json);
    }
    throw Exception('Invalid type for data: $json');
  }

  static dynamic _toJson(dynamic object) {
    if (object is String) {
      return object;
    } else if (object is DataListAddress) {
      return object.toJson();
    }
    return null;
  }
}
