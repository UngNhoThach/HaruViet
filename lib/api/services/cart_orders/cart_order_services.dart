import 'dart:async';

import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';

import 'models/check_order_price_request/check_order_price_request.dart';

class CartOrderService extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');

  Future<Response> getStatusOrdersSV() async {
    final response = await get(CartApi.getStatusOrders,
        headers: apiHeaders.appMobileHeaders);
    return response;
  }

  Future<Response> getHistoryOrdersSV(
      {required String idCustomer, required int status}) async {
    final response = await get(
        CartApi.getHistoryOrders
            .replaceAll(RegExp('{idCustomer}'), idCustomer)
            .replaceAll(RegExp('{status}'), status.toString()),
        headers: apiHeaders.appMobileHeaders);
    return response;
  }

  Future<Response> getOderDetailSV(
      {required String idCustomer, required String idOrder}) async {
    final response = await get(
        CartApi.getOderDetail
            .replaceAll(RegExp('{idCustomer}'), idCustomer)
            .replaceAll(RegExp('{idOrder}'), idOrder),
        headers: apiHeaders.appMobileHeaders);
    return response;
  }

  //

  Future<Response> checkOrderPriceSV({
    required CheckOrderPriceRequest request,
  }) async {
    final response = await post(CartApi.checkOrderPrice,
        data: request.toJson(), headers: apiHeaders.appMobileHeaders);
    return response;
  }
}
