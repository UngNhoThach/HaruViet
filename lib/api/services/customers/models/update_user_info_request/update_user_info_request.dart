import 'package:json_annotation/json_annotation.dart';

part 'update_user_info_request.g.dart';

@JsonSerializable()
class UpdateUserInfoRequest {
  String? birthday;
  @JsonKey(name: 'address_id')
  String? addressId;
  String? name;
  String? avatar;
  String? pathologicaldetail;
  @JsonKey(name: 'agency_id')
  int? agencyId;
  @JsonKey(name: 'user_id')
  int? userId;
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
  String? sex;
  String? postcode;
  String? address;

  String? address1;
  String? address2;
  String? address3;

  String? company;
  String? country;
  String? phone;
  String? provider;
  @JsonKey(name: 'provider_id')
  String? providerId;

  UpdateUserInfoRequest({
    this.birthday,
    this.addressId,
    this.name,
    this.avatar,
    this.pathologicaldetail,
    this.agencyId,
    this.userId,
    this.agencyName,
    this.userName,
    this.firstName,
    this.lastName,
    this.firstNameKana,
    this.lastNameKana,
    this.sex,
    this.postcode,
    this.address,
    this.address1,
    this.address2,
    this.address3,
    this.company,
    this.country,
    this.phone,
    this.provider,
    this.providerId,
  });

  factory UpdateUserInfoRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateUserInfoRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateUserInfoRequestToJson(this);
}
