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
  String? house;
  String? street;
  String? ward;
  String? district;
  String? province;
  dynamic postcode;
  @JsonKey(name: 'id_province')
  int? idProvince;
  @JsonKey(name: 'id_district')
  int? idDistrict;
  @JsonKey(name: 'id_ward')
  int? idWard;
  String? phone;
  String? country;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  bool isDefault;
  bool isShipping;

  DataListAddress({
    this.isDefault = false,
    this.isShipping = false,
    this.id,
    this.customerId,
    this.firstName,
    this.lastName,
    this.firstNameKana,
    this.lastNameKana,
    this.house,
    this.street,
    this.ward,
    this.district,
    this.province,
    this.postcode,
    this.idProvince,
    this.idDistrict,
    this.idWard,
    this.phone,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  factory DataListAddress.fromJson(Map<String, dynamic> json) {
    return _$DataListAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataListAddressToJson(this);

  DataListAddress copyWith({
    String? id,
    String? customerId,
    String? firstName,
    String? lastName,
    String? firstNameKana,
    String? lastNameKana,
    String? house,
    String? street,
    String? ward,
    String? district,
    String? province,
    dynamic postcode,
    int? idProvince,
    int? idDistrict,
    int? idWard,
    String? phone,
    String? country,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDefault,
    bool? isShipping,
  }) {
    return DataListAddress(
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      customerId: customerId ?? this.customerId,
      district: district ?? this.district,
      firstName: firstName ?? this.firstName,
      firstNameKana: firstNameKana ?? this.firstNameKana,
      house: house ?? this.house,
      id: id ?? this.id,
      idDistrict: idDistrict ?? this.idDistrict,
      idProvince: idProvince ?? this.idProvince,
      idWard: idWard ?? this.idWard,
      isDefault: isDefault ?? this.isDefault,
      isShipping: isShipping ?? this.isShipping,
      lastName: lastName ?? this.lastName,
      lastNameKana: lastNameKana ?? this.lastNameKana,
      phone: phone ?? this.phone,
      postcode: postcode ?? this.postcode,
      province: province ?? this.province,
      street: street ?? this.street,
      updatedAt: updatedAt ?? this.updatedAt,
      ward: ward ?? this.ward,
    );
  }
}
