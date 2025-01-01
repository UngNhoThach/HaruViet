// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCustomer _$DataCustomerFromJson(Map<String, dynamic> json) => DataCustomer(
      id: json['id'] as String?,
      avatar: json['avatar'],
      sku: json['sku'],
      pathologicaldetail: json['pathologicaldetail'],
      agencyId: json['agency_id'] as String?,
      userId: json['user_id'] as String?,
      agencyName: json['agency_name'],
      userName: json['user_name'],
      firstName: json['first_name'] as String?,
      lastName: json['last_name'],
      firstNameKana: json['first_name_kana'],
      lastNameKana: json['last_name_kana'],
      email: json['email'] as String?,
      sex: json['sex'],
      birthday: json['birthday'],
      addressId: json['address_id'] as String?,
      postcode: json['postcode'],
      address1: json['address1'],
      address2: json['address2'],
      address3: json['address3'],
      company: json['company'],
      country: json['country'] as String?,
      phone: json['phone'],
      storeId: json['store_id'] as String?,
      status: (json['status'] as num?)?.toInt(),
      group: (json['group'] as num?)?.toInt(),
      emailVerifiedAt: json['email_verified_at'] as String?,
      phoneVerifiedAt: json['phone_verified_at'],
      otpVerified: (json['otp_verified'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      provider: json['provider'],
      providerId: json['provider_id'],
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DataCustomerToJson(DataCustomer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'sku': instance.sku,
      'pathologicaldetail': instance.pathologicaldetail,
      'agency_id': instance.agencyId,
      'user_id': instance.userId,
      'agency_name': instance.agencyName,
      'user_name': instance.userName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'first_name_kana': instance.firstNameKana,
      'last_name_kana': instance.lastNameKana,
      'email': instance.email,
      'sex': instance.sex,
      'birthday': instance.birthday,
      'address_id': instance.addressId,
      'postcode': instance.postcode,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'company': instance.company,
      'country': instance.country,
      'phone': instance.phone,
      'store_id': instance.storeId,
      'status': instance.status,
      'group': instance.group,
      'email_verified_at': instance.emailVerifiedAt,
      'phone_verified_at': instance.phoneVerifiedAt,
      'otp_verified': instance.otpVerified,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'provider': instance.provider,
      'provider_id': instance.providerId,
      'name': instance.name,
    };
