import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/data/reponsitory/setting/models/item_base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class AddressResponse {
  @JsonKey(name: 'data')
  List<ItemBaseResponse>? data;

  AddressResponse({
    this.data,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return _$AddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}
