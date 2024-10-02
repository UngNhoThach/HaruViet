import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_exception.dart';
import 'package:haruviet/api/rest_clien_ghtk.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/web.dart';

abstract class BaseServiceGHTK {
  final Logger _logger = Logger();

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await RestClientGHTK.dio.get(
        path,
        queryParameters: params,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            // Define which status codes should not throw an error
            // Return `true` for the range of status codes you want to consider valid
            return status != null &&
                status < 500; // Allow anything < 500 to be valid
          },
        ),
      );

      _logger.i('path: $path \nparams: $params\nresponse: $response');

      // Process the response
      return _handleResponse(response);
    } catch (error, stackTrace) {
      if (error is DioError) {
        // Handle DioError specifically
        if (error.response?.statusCode == 500) {
          // Handle server-side errors (500)
          print("Server error: ${error.response?.statusCode}");
          _logger.e("Server error (500): ${error.response?.data}");
        } else {
          // Handle other status codes or network errors
          print("DioError: ${error.message}");
          _logger.e("DioError: ${error.message}");
        }
      } else {
        // Handle any other types of errors (non-DioError)
        print("Unexpected error: $error");
        _logger.e("Unexpected error: $error + $stackTrace");
      }

      // Optionally, you can return a default value or rethrow the error
      return Future.error(error); // Return error if you want to propagate it
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    // ignoreResultCode = false,
    // String? dataKey
  }) async {
    try {
      final response = await RestClientGHTK.dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );
      _logger.i('path: $path \ndata: $data\nresponse: $response');
      return _handleResponse(response);
    } catch (error, stackTrace) {
      print("$error + $stackTrace");
      //  _handleError(error.toString());
    }
  }

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? data,
    // ignoreResultCode = false,
    // String? dataKey
  }) async {
    final response = await RestClientGHTK.dio.put(path, data: data);
    _logger.i('path: $path \ndata: $data\nresponse: $response');
    return _handleResponse(response);
  }

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? data,
    // ignoreResultCode = false,
    // String? dataKey
  }) async {
    final response = await RestClientGHTK.dio.delete(path, data: data);
    _logger.i('path: $path \ndata: $data\nresponse: $response');
    return _handleResponse(response);
  }

  Future<dynamic> postFormData(String path, {dio.FormData? data}) async {
    final response = await RestClientGHTK.dio.post(path, data: data);
    _logger.i('path: $path \ndata: $data\nresponse: $response');
    return _handleResponse(response);
  }

  dynamic _handleResponse(dio.Response response) {
    if (response.statusCode != 200) {
      throw ApiException.fromJson(response.data);
    }

    if (response.data is String) {
      return response.data;
    }
    return response;
  }
}
