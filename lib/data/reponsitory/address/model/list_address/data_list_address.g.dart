// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataListAddress _$DataListAddressFromJson(Map<String, dynamic> json) =>
    DataListAddress(
      isDefault: json['isDefault'] as bool? ?? false,
      isShipping: json['isShipping'] as bool? ?? false,
      id: json['id'] as String?,
      customerId: json['customer_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      firstNameKana: json['first_name_kana'] as String?,
      lastNameKana: json['last_name_kana'] as String?,
      house: json['house'] as String?,
      street: json['street'] as String?,
      ward: json['ward'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      postcode: json['postcode'],
      idProvince: (json['id_province'] as num?)?.toInt(),
      idDistrict: (json['id_district'] as num?)?.toInt(),
      idWard: (json['id_ward'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      country: json['country'] as String?,
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
      'house': instance.house,
      'street': instance.street,
      'ward': instance.ward,
      'district': instance.district,
      'province': instance.province,
      'postcode': instance.postcode,
      'id_province': instance.idProvince,
      'id_district': instance.idDistrict,
      'id_ward': instance.idWard,
      'phone': instance.phone,
      'country': instance.country,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'isDefault': instance.isDefault,
      'isShipping': instance.isShipping,
    };
