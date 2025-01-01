import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/customers/models/register_request.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';
import 'package:haruviet/data/data_local/user_state.dart';

import 'models/update_password_phone_number_request/update_password_phone_number_request.dart';

class CustomersService extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');

  Future<Response> registerSV({required RegisterRequest request}) async {
    final response = await post(
      CustomersApi.register,
      data: request.toJson(),
      // headers: apiHeaders.appMobileHeaders,
    );
    return response;
  }

  Future<Response> verifySV({required String username}) async {
    final response = await post(
      CustomersApi.verify,
      data: {
        'username': username,
      },
      // headers: apiHeaders.appMobileHeaders,
    );
    return response;
  }

  // login
  Future<Response> loginSV(
      {required String username, required String password}) async {
    final response = await post(
      CustomersApi.login,
      data: {'username': username, 'password': password},
      // headers: apiHeaders.appMobileHeaders,
    );
    return response;
  }

  //loginGoogle
  Future<Response> loginGoogleSV({required String token}) async {
    final response = await post(
      CustomersApi.loginGoogle,
      data: {
        'token': token,
      },
    );
    return response;
  }

  // updateInfo
  Future<Response> updateInfoSV(
      {required UserState request, required String authorization}) async {
    final response = await post(
      CustomersApi.updateInfo,
      data: request.toJson(),
    );
    return response;
  }

  // updaet pasaword by phone number
  Future<Response> updatePassWordSV(
      {required UpdatePasswordPhoneNumberRequest request}) async {
    final response = await post(
      CustomersApi.updatePassWord,
      data: request.toJson(),
      // headers: apiHeaders.appMobileHeaders,
    );
    return response;
  }

  Future<Response> forgetPassSV({required String username}) async {
    final response = await post(
      CustomersApi.forgotPass,
      data: {
        'username': username,
      },
      // headers: apiHeaders.appMobileHeaders,
    );
    return response;
  }

  Future<Response> getInfoUserSV({required String authorization}) async {
    final response = await get(
      CustomersApi.getInfoUser,
      // headers: ApiHeaders(authorization).appMobileHeaders
    );
    return response;
  }
}
