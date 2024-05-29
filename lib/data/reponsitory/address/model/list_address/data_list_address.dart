import 'package:json_annotation/json_annotation.dart';

part 'data_list_address.g.dart';

@JsonSerializable()
class DataListAddress {
  String? id;
  @JsonKey(name: 'customer_id')
  String? customerId;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'first_name_kana')
  String? firstNameKana;
  @JsonKey(name: 'last_name_kana')
  String? lastNameKana;
  String? postcode;
  String? address1;
  String? address2;
  String? address3;
  @JsonKey(name: 'id_address')
  String? idAddress;
  String? country;
  String? phone;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  bool isDefault;

  DataListAddress({
    this.id,
    this.isDefault = false,
    this.customerId,
    this.firstName,
    this.idAddress,
    this.lastName,
    this.firstNameKana,
    this.lastNameKana,
    this.postcode,
    this.address1,
    this.address2,
    this.address3,
    this.country,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory DataListAddress.fromJson(Map<String, dynamic> json) =>
      _$DataListAddressFromJson(json);

  Map<String, dynamic> toJson() => _$DataListAddressToJson(this);

  copyWith({required}) {}
}
