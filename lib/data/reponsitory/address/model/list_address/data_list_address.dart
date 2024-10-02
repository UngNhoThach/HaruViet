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
  bool isShipping;

  DataListAddress({
    this.id,
    this.isDefault = false,
    this.isShipping = false,
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

  DataListAddress copyWith({
    String? id,
    String? customerId,
    String? firstName,
    String? lastName,
    String? firstNameKana,
    String? lastNameKana,
    String? postcode,
    String? address1,
    String? address2,
    String? address3,
    String? idAddress,
    String? country,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDefault,
    bool? isShipping,
  }) {
    return DataListAddress(
      isShipping: isShipping ?? this.isShipping,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      customerId: customerId ?? this.customerId,
      firstName: firstName ?? this.firstName,
      firstNameKana: firstNameKana ?? this.firstNameKana,
      id: id ?? this.id,
      idAddress: idAddress ?? this.idAddress,
      isDefault: isDefault ?? this.isDefault,
      lastName: lastName ?? this.lastName,
      lastNameKana: lastNameKana ?? this.lastNameKana,
      phone: phone ?? this.phone,
      postcode: postcode ?? this.postcode,
    );
  }
}
