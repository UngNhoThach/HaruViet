import 'dart:convert';
import 'package:eco_app/data/user/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static const kUserInfo = "user_info";
  static const kCallData = "call_data";
  static const kPrevRoomId = "prev_room_id";
  static const kPlanData = 'plan_data';

// lưu thông tin người dùng vào bộ nhớ cục bộ
  static setUserInfo(UserInfoLogin user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserInfo, jsonEncode(user.toJson()));
  }

// lấy thông  tin user từ bộ nhớ cục bộ
  static Future<UserInfoLogin?> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(kUserInfo);
    if (userJson != null) return UserInfoLogin.fromJson(json.decode(userJson));
    return null;
  }

//
  // static setCallData(FirebaseCallDataResponse user) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(kCallData, jsonEncode(user.toJson()));
  // }

  // static Future<FirebaseCallDataResponse?> getCallData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final dataJson = prefs.getString(kCallData);
  //   if (dataJson != null && dataJson.isNotEmpty) {
  //     prefs.setString(kCallData, '');
  //     return FirebaseCallDataResponse.fromJson(json.decode(dataJson));
  //   }
  //   return null;
  // }

  static setPrevRoomId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kPrevRoomId, id);
  }

  static Future<String?> getPrevRoomId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(kPrevRoomId);
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return null;
  }

  static setPlanData(String id, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (id.isNotEmpty) {
      Map<String, dynamic> planData = {
        'id': id,
        'name': name,
      };
      await prefs.setString(kPlanData, json.encode(planData));
    } else {
      await prefs.setString(kPlanData, '');
    }
  }

  static Future<Map<String, dynamic>?> getPlanData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(kPlanData);
    if (jsonData != null && jsonData.isNotEmpty) {
      return json.decode(jsonData);
    }
    return null;
  }
}
