import 'package:json_annotation/json_annotation.dart';

part 'user_state.g.dart';

@JsonSerializable()
class UserState {
  String? id;
  String? avatar;
  String? sku;
  String? pathologicaldetail;
  @JsonKey(name: 'agency_id')
  String? agencyId;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'address_id')
  String? addressId;
  @JsonKey(name: 'agency_name')
  String? agencyName;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'first_name_kana')
  String? firstNameKana;
  @JsonKey(name: 'last_name_kana')
  String? lastNameKana;
  String? email;
  String? phone;
  int? sex;
  dynamic birthday;
  String? house;
  String? street;
  String? ward;
  String? district;
  String? province;
  String? postcode;
  @JsonKey(name: 'id_province')
  String? idProvince;
  @JsonKey(name: 'id_district')
  String? idDistrict;
  @JsonKey(name: 'id_ward')
  String? idWard;
  String? company;
  String? country;
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
  bool isLogin;
  @JsonKey(name: "access_token")
  String? accessToken;
  @JsonKey(name: "token_type")
  String? tokenType;

  UserState({
    this.tokenType,
    this.accessToken,
    this.isLogin = false,
    this.id,
    this.avatar,
    this.sku,
    this.pathologicaldetail,
    this.agencyId,
    this.userId,
    this.addressId,
    this.agencyName,
    this.userName,
    this.firstName,
    this.lastName,
    this.firstNameKana,
    this.lastNameKana,
    this.email,
    this.phone,
    this.sex,
    this.birthday,
    this.house,
    this.street,
    this.ward,
    this.district,
    this.province,
    this.postcode,
    this.idProvince,
    this.idDistrict,
    this.idWard,
    this.company,
    this.country,
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

  factory UserState.fromJson(Map<String, dynamic> json) {
    return _$UserStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserStateToJson(this);
}
