import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  String? id;
  dynamic avatar;
  dynamic sku;
  dynamic pathologicaldetail;
  @JsonKey(name: 'agency_id')
  String? agencyId;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'agency_name')
  dynamic agencyName;
  @JsonKey(name: 'user_name')
  dynamic userName;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  dynamic lastName;
  @JsonKey(name: 'first_name_kana')
  dynamic firstNameKana;
  @JsonKey(name: 'last_name_kana')
  dynamic lastNameKana;
  String? email;
  dynamic sex;
  dynamic birthday;
  @JsonKey(name: 'address_id')
  String? addressId;
  dynamic postcode;
  dynamic address1;
  dynamic address2;
  dynamic address3;
  dynamic company;
  String? country;
  dynamic phone;
  @JsonKey(name: 'store_id')
  String? storeId;
  int? status;
  int? group;
  @JsonKey(name: 'email_verified_at')
  String? emailVerifiedAt;
  @JsonKey(name: 'phone_verified_at')
  dynamic phoneVerifiedAt;
  @JsonKey(name: 'otp_verified')
  int? otpVerified;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  dynamic provider;
  @JsonKey(name: 'provider_id')
  dynamic providerId;
  String? name;

  Data({
    this.id,
    this.avatar,
    this.sku,
    this.pathologicaldetail,
    this.agencyId,
    this.userId,
    this.agencyName,
    this.userName,
    this.firstName,
    this.lastName,
    this.firstNameKana,
    this.lastNameKana,
    this.email,
    this.sex,
    this.birthday,
    this.addressId,
    this.postcode,
    this.address1,
    this.address2,
    this.address3,
    this.company,
    this.country,
    this.phone,
    this.storeId,
    this.status,
    this.group,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.otpVerified,
    this.createdAt,
    this.updatedAt,
    this.provider,
    this.providerId,
    this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
