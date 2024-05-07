// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserInfoRequest _$UpdateUserInfoRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserInfoRequest(
      birthday: json['birthday'] as String?,
      addressId: json['address_id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      pathologicaldetail: json['pathologicaldetail'] as String?,
      agencyId: json['agency_id'] as int?,
      userId: json['user_id'] as int?,
      agencyName: json['agency_name'] as String?,
      userName: json['user_name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      firstNameKana: json['first_name_kana'] as String?,
      lastNameKana: json['last_name_kana'] as String?,
      sex: json['sex'] as String?,
      postcode: json['postcode'] as String?,
      address: json['address'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      company: json['company'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
      provider: json['provider'] as String?,
      providerId: json['provider_id'] as String?,
    );

Map<String, dynamic> _$UpdateUserInfoRequestToJson(
        UpdateUserInfoRequest instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
      'address_id': instance.addressId,
      'name': instance.name,
      'avatar': instance.avatar,
      'pathologicaldetail': instance.pathologicaldetail,
      'agency_id': instance.agencyId,
      'user_id': instance.userId,
      'agency_name': instance.agencyName,
      'user_name': instance.userName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'first_name_kana': instance.firstNameKana,
      'last_name_kana': instance.lastNameKana,
      'sex': instance.sex,
      'postcode': instance.postcode,
      'address': instance.address,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'company': instance.company,
      'country': instance.country,
      'phone': instance.phone,
      'provider': instance.provider,
      'provider_id': instance.providerId,
    };
