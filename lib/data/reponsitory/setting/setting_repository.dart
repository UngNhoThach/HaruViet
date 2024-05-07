import 'package:eco_app/api/services/setting/setting_services.dart';
import 'package:eco_app/data/reponsitory/setting/item_base_response.dart';
import 'package:flutter/foundation.dart';

class SettingRepository {
  final _settingService = SettingService();

  Future<List<ItemBaseResponse>> getCountryListRP() async {
    try {
      final response = await _settingService.getCountryListSV();
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
    required int countryId,
  }) async {
    try {
      final response = await _settingService.getDistrictListSV(
          countryId: countryId.toString());
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
    required int districtId,
  }) async {
    try {
      final response = await _settingService.getWardListSV(
          districtId: districtId.toString());
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
