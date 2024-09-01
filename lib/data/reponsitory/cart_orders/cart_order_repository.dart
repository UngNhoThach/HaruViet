import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/cart_orders/cart_order_services.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';

import 'models/cart_order_response/cart_order_response.dart';
import 'models/cart_order_status_response/cart_order_status_response.dart';

class CartOrderRepository extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');
  final _cartOrderService = CartOrderService();

  Future<CartOrderStatusResponse> getStatusOrderRP() async {
    try {
      final response = await _cartOrderService.getStatusOrdersSV();
      final result = CartOrderStatusResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return CartOrderStatusResponse();
  }

  Future<CartOrderResponse> getHistoryOrdersRP(
      {required String idCustomer, required int status}) async {
    try {
      final response = await _cartOrderService.getHistoryOrdersSV(
          idCustomer: idCustomer, status: status);
      final result = CartOrderResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return CartOrderResponse();
  }
}
