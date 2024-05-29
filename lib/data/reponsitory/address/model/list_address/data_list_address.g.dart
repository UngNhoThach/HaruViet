// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataListAddress _$DataListAddressFromJson(Map<String, dynamic> json) =>
    DataListAddress(
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      customerId: json['customer_id'] as String?,
      firstName: json['first_name'] as String?,
      idAddress: json['id_address'] as String?,
      lastName: json['last_name'] as String?,
      firstNameKana: json['first_name_kana'] as String?,
      lastNameKana: json['last_name_kana'] as String?,
      postcode: json['postcode'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DataListAddressToJson(DataListAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'first_name_kana': instance.firstNameKana,
      'last_name_kana': instance.lastNameKana,
      'postcode': instance.postcode,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'id_address': instance.idAddress,
      'country': instance.country,
      'phone': instance.phone,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'isDefault': instance.isDefault,
    };
