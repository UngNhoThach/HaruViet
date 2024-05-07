import 'package:json_annotation/json_annotation.dart';

part 'user_register.g.dart';

@JsonSerializable()
class UserRegister {
  String? id;
  @JsonKey(name: 'avatar')
  String? avatar;
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

  @JsonKey(name: 'postcode')
  String? postcode;
  @JsonKey(name: 'address1')
  String? address1;
  @JsonKey(name: 'address2')
  String? address2;
  @JsonKey(name: 'address3')
  String? address3;
  @JsonKey(name: 'company')
  String? company;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'store_id')
  String? storeId;
  int? status;
  int? group;
  @JsonKey(name: 'email_verified_at')
  String? emailVerifiedAt;
  @JsonKey(name: 'phone_verified_at')
  String? phoneVerifiedAt;
  @JsonKey(name: 'otp_verified')
  int? otpVerified;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  String? provider;
  @JsonKey(name: 'provider_id')
  String? providerId;
  String? name;

  UserRegister({
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

  factory UserRegister.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterToJson(this);
}
