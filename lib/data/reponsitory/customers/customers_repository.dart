import 'package:haruviet/api/services/customers/customers_services.dart';
import 'package:haruviet/api/services/customers/models/register_request.dart';
import 'package:haruviet/api/services/customers/models/update_password_phone_number_request/update_password_phone_number_request.dart';
import 'package:haruviet/api/services/customers/models/update_user_info_request/update_user_info_request.dart';
import 'package:haruviet/data/reponsitory/customers/models/user_update_info_response/user_update_info_response.dart';
import 'package:haruviet/data/reponsitory/normal_response/normal_response.dart';
import 'package:flutter/foundation.dart';

import 'models/login_response/login_response.dart';
import 'models/register_response/register_response.dart';

class CustomersRepository {
  final _customerService = CustomersService();

  Future<RegisterResponse> registerRP(
      {required RegisterRequest request}) async {
    try {
      final response = await _customerService.registerSV(request: request);
      final result = RegisterResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return RegisterResponse();
  }

  Future<NormalResponse> verifyRP({required String username}) async {
    try {
      final response = await _customerService.verifySV(username: username);
      final result = NormalResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return NormalResponse();
    }
  }

  Future<NormalResponse> forgetPassRP({required String username}) async {
    try {
      final response = await _customerService.forgetPassSV(username: username);
      final result = NormalResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return NormalResponse();
    }
  }

  // login
  Future<LoginResponse> loginRP(
      {required String username, required String password}) async {
    try {
      final response = await _customerService.loginSV(
          username: username, password: password);
      final result = LoginResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return LoginResponse();
    }
  }

  // loginGoogle
  Future<LoginResponse> loginGoogleRP({required String token}) async {
    try {
      final response = await _customerService.loginGoogleSV(token: token);
      final result = LoginResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return LoginResponse();
    }
  }

  Future<UserUpdateInfoResponse> updateInfoRP(
      {required UpdateUserInfoRequest request,
      required String authorization}) async {
    try {
      final response = await _customerService.updateInfoSV(
          request: request, authorization: authorization);
      final result = UserUpdateInfoResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return UserUpdateInfoResponse();
    }
  }

  // forgetPassRP
  Future<UserUpdateInfoResponse> updatePassWordRP(
      {required UpdatePasswordPhoneNumberRequest request}) async {
    try {
      final response =
          await _customerService.updatePassWordSV(request: request);
      final result = UserUpdateInfoResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return UserUpdateInfoResponse();
    }
  }

  Future<UserUpdateInfoResponse> getInfoUserRP(
      {required String authorization}) async {
    try {
      final response =
          await _customerService.getInfoUserSV(authorization: authorization);
      final result = UserUpdateInfoResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return UserUpdateInfoResponse();
    }
  }
}
