import 'package:eco_app/api/services/setting/setting_services.dart';
import 'package:eco_app/data/reponsitory/setting/item_base_response.dart';
import 'package:flutter/foundation.dart';

class SettingRepository {
  final _settingService = SettingService();

  Future<List<ItemBaseResponse>> getCountryListRP({
    required int idCountry,
  }) async {
    try {
      final response = await _settingService.getCountryListSV(
          idCountry: idCountry.toString());
      final result = ItemBaseResponse.fromJsonArray(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }

  Future<List<ItemBaseResponse>> getDistrictListRP({
    required int idProvince,
  }) async {
    try {
      final response = await _settingService.getDistrictListSV(
        idProvince: idProvince.toString(),
      );
      final result = ItemBaseResponse.fromJsonArray(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }

  Future<List<ItemBaseResponse>> getWardListRP({
    required int idDistrict,
  }) async {
    try {
      final response = await _settingService.getWardListSV(
        idDistrict: idDistrict.toString(),
      );
      final result = ItemBaseResponse.fromJsonArray(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }
}
