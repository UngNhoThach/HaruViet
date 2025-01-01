import 'dart:convert';
import 'package:haruviet/data/data_local/setting_app_state.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/reponsitory/payment/payment_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static const kUserInfo = "user_info";
  static const kAddressShipping = "address_shipping";
  static const kPayment = "payment";
  static const appConfig = "appconfig";

  // app config
  static setAppConfig(SettingAppState appconfigData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(appConfig, jsonEncode(appconfigData.toJson()));
  }

  static Future<SettingAppState?> getAppConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final appconfigDataJson = prefs.getString(appConfig);
    if (appconfigDataJson != null) {
      return SettingAppState.fromJson(json.decode(appconfigDataJson));
    }
    return null;
  }

  // payment
  static setPayment(PaymentData paymentData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kPayment, jsonEncode(paymentData.toJson()));
  }

  static Future<PaymentData?> getPayment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final paymentJson = prefs.getString(kPayment);
    if (paymentJson != null) {
      return PaymentData.fromJson(json.decode(paymentJson));
    }
    return null;
  }

  static setAddressShipping(DataListAddress address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kAddressShipping, jsonEncode(address.toJson()));
  }

  static Future<DataListAddress?> getAddressShipping() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final addressJson = prefs.getString(kAddressShipping);
    if (addressJson != null) {
      return DataListAddress.fromJson(json.decode(addressJson));
    }
    return null;
  }

// lưu thông tin người dùng vào bộ nhớ cục bộ
  static setUserInfo(UserState user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserInfo, jsonEncode(user.toJson()));
  }

// lấy thông  tin user từ bộ nhớ cục bộ
  static Future<UserState?> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(kUserInfo);
    if (userJson != null) return UserState.fromJson(json.decode(userJson));
    return null;
  }

  static Future<void> updateUserInfo(Map<String, dynamic> updates) async {
    UserState? currentUser = await getUserInfo();

    if (currentUser != null) {
      // Tạo một bản sao của thông tin người dùng hiện tại dưới dạng Map
      Map<String, dynamic> currentUserMap = currentUser.toJson();

      // Cập nhật các trường với dữ liệu mới
      updates.forEach((key, value) {
        currentUserMap[key] = value;
      });
      // Chuyển lại Map thành đối tượng UserState
      UserState updatedUser = UserState.fromJson(currentUserMap);

      await setUserInfo(updatedUser);
    }
  }

  // To clear data but keep appConfig
  static Future<void> clearDataButKeepAppConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final appConfigData = prefs.getString(appConfig);

    // Clear all data
    await prefs.clear();

    // Restore the app config data
    if (appConfigData != null) {
      await prefs.setString(appConfig, appConfigData);
    }
  }
}
