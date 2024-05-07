import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_state.g.dart';

@JsonSerializable()
@CopyWith()
class UserInfoLogin {
  bool isLogin;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "access_token")
  String? accessToken;
  @JsonKey(name: "token_type")
  String? tokenType;
  @JsonKey(name: "emai")
  String? email;
  @JsonKey(name: "email_verified_at")
  String? emailVerifiedAt;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "first_name_kana")
  String? firstNameKana;
  @JsonKey(name: "last_name_kana")
  String? lastNameKana;
  @JsonKey(name: "sex")
  String? sex;
  @JsonKey(name: "birthday")
  String? birthDay;
  @JsonKey(name: "address_id")
  String? addressId;
  @JsonKey(name: "postcode")
  String? postCode;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "address1")
  String? address1;
  @JsonKey(name: "address1ID")
  String? address1ID;

  @JsonKey(name: "address2")
  String? address2;
  @JsonKey(name: "address2ID")
  String? address2ID;

  @JsonKey(name: "address3")
  String? address3;
  @JsonKey(name: "address3ID")
  String? address3ID;

  @JsonKey(name: "company")
  String? company;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "store_id")
  String? storeId;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "group")
  int? group;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "agency_name")
  String? agencyName;
  @JsonKey(name: "avatar")
  String? avatar;

  UserInfoLogin(
      {this.isLogin = false,
      this.id,
      this.accessToken,
      this.tokenType,
      this.email,
      this.emailVerifiedAt,
      this.name,
      this.firstName,
      this.lastName,
      this.firstNameKana,
      this.lastNameKana,
      this.sex,
      this.birthDay,
      this.addressId,
      this.address,
      this.address1,
      this.address1ID,
      this.postCode,
      this.address2,
      this.address2ID,
      this.address3,
      this.address3ID,
      this.company,
      this.country,
      this.phone,
      this.storeId,
      this.status,
      this.group,
      this.userId,
      this.agencyName,
      this.avatar});

  @override
  String toString() {
    return 'avatar: $avatar,  id: $id, access_token: $accessToken, token_type: $tokenType, emai: $email, email_verified_at: $emailVerifiedAt,  name: $name, first_name: $firstName, last_name: $lastName , first_name_kana $firstNameKana,  last_name_kana $lastNameKana, sex $sex, birthday $birthDay, address_id $addressId, postcode $postCode, address1 $address1, address2 $address2, address3 $address3, company $company, country $company, phone $phone, store_id $storeId, status $status, group $group, user_id $userId, agency_name $agencyName';
  }

  factory UserInfoLogin.fromJson(Map<String, dynamic> json) =>
      _$UserInfoLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoLoginToJson(this);
}
