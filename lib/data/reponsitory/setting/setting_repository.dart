import 'package:haruviet/api/services/setting/setting_services.dart';
import 'package:haruviet/data/data_local/setting_app_state.dart';
import 'package:haruviet/data/reponsitory/setting/models/address_response.dart';
import 'package:haruviet/data/reponsitory/setting/models/item_base_response.dart';
import 'package:flutter/foundation.dart';

class SettingRepository {
  final _settingService = SettingService();

  Future<AddressResponse> getCountryListRP({
    required int idCountry,
  }) async {
    try {
      final response = await _settingService.getCountryListSV(
          idCountry: idCountry.toString());
      final result = AddressResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return AddressResponse();
    }
  }

  Future<AddressResponse> getDistrictListRP({
    required int idProvince,
  }) async {
    try {
      final response = await _settingService.getDistrictListSV(
        idProvince: idProvince.toString(),
      );
      final result = AddressResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return AddressResponse();
    }
  }

  Future<AddressResponse> getWardListRP({
    required int idDistrict,
  }) async {
    try {
      final response = await _settingService.getWardListSV(
        idDistrict: idDistrict.toString(),
      );
      final result = AddressResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return AddressResponse();
    }
  }

  Future<SettingAppState> fetchAndStoreSettings() async {
    try {
      final response = await _settingService.getAppDefault(
          apiKey: "d6e73ca5bad43896f7b4bed807932fe3", name: "haruviet");

      final headers = response.headers;
      final settings = SettingAppState(
        xApiKey: headers["X-ApiKey"]?.first,
        date: headers["date"]?.first,
        xName: headers["X-Name"]?.first,
        xUrl: headers["X-Url"]?.first,
        xPoweredBy: headers["X-Powered-By"]?.first,
      );
      return settings;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("$error + $stackTrace");
      }
      return SettingAppState();
    }
  }
}
