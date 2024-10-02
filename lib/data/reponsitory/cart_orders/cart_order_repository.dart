import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/cart_orders/cart_order_services.dart';
import 'package:haruviet/api/services/cart_orders/models/check_order_price_request/check_order_price_request.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';
import 'package:haruviet/data/reponsitory/respone_general.dart';

import 'models/check_order_price_response/check_order_price_response.dart';
import 'models/get_order_detail/get_order_detail.dart';

class CartOrderRepository extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');
  final _cartOrderService = CartOrderService();

  Future<GeneralResponse> getStatusOrderRP() async {
    try {
      final response = await _cartOrderService.getStatusOrdersSV();
      final result = GeneralResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GeneralResponse();
  }

  Future<GeneralResponse> getHistoryOrdersRP(
      {required String idCustomer, required int status}) async {
    try {
      final response = await _cartOrderService.getHistoryOrdersSV(
          idCustomer: idCustomer, status: status);
      final result = GeneralResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GeneralResponse();
  }

  // get order details
  Future<GetOrderDetail> getOderDetailRP(
      {required String idCustomer, required String idOrder}) async {
    try {
      final response = await _cartOrderService.getOderDetailSV(
          idCustomer: idCustomer, idOrder: idOrder);
      final result = GetOrderDetail.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GetOrderDetail();
  }

  Future<List<CheckOrderPriceResponse>> checkOrderPriceRP(
      {required CheckOrderPriceRequest request}) async {
    try {
      final response =
          await _cartOrderService.checkOrderPriceSV(request: request);
      final result = CheckOrderPriceResponse.fromJsonArray(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return [];
  }
}
