import 'dart:convert';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static const kUserInfo = "user_info";

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

  // Hàm cập nhật thông tin người dùng
  static Future<void> updateUserInfo(Map<String, dynamic> updates) async {
    // Lấy thông tin người dùng hiện tại
    UserInfoLogin? currentUser = await getUserInfo();

    // Kiểm tra nếu người dùng tồn tại
    if (currentUser != null) {
      // Tạo một bản sao của thông tin người dùng hiện tại dưới dạng Map
      Map<String, dynamic> currentUserMap = currentUser.toJson();

      // Cập nhật các trường với dữ liệu mới
      updates.forEach((key, value) {
        currentUserMap[key] = value;
      });
      // Chuyển lại Map thành đối tượng UserInfoLogin
      UserInfoLogin updatedUser = UserInfoLogin.fromJson(currentUserMap);

      // Lưu thông tin người dùng đã cập nhật vào bộ nhớ cục bộ
      await setUserInfo(updatedUser);
    }
  }
}
