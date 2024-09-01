import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_exception.dart';
import 'package:haruviet/api/rest_client.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/web.dart';

abstract class BaseService {
  final Logger _logger = Logger();

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    //  ignoreResultCode = false,
    //   String? dataKey
  }) async {
    try {
      final response = await RestClient.dio.get(
        path,
        queryParameters: params,
        options: Options(headers: headers),
      );
      _logger.i('path: $path \nparams: $params\nresponse: $response');
      return _handleResponse(response);
    } catch (error, stackTrace) {
      print("$error + $stackTrace");
      //  _handleError(error.toString());
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
      final response = await RestClient.dio.post(
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
    final response = await RestClient.dio.put(path, data: data);
    _logger.i('path: $path \ndata: $data\nresponse: $response');
    return _handleResponse(response);
  }

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? data,
    // ignoreResultCode = false,
    // String? dataKey
  }) async {
    final response = await RestClient.dio.delete(path, data: data);
    _logger.i('path: $path \ndata: $data\nresponse: $response');
    return _handleResponse(response);
  }

  Future<dynamic> postFormData(String path, {dio.FormData? data}) async {
    final response = await RestClient.dio.post(path, data: data);
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
