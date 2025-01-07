import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/cart_orders/cart_order_services.dart';
import 'package:haruviet/api/services/cart_orders/models/add_products_request/add_products_request.dart';
import 'package:haruviet/api/services/cart_orders/models/check_order_price_request/check_order_price_request.dart';
import 'package:haruviet/api/services/cart_orders/models/check_shipping_fee/check_shipping_fee_request.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/create_order_request.dart';
import 'package:haruviet/api/services/cart_orders/models/remove_item_from_cart_request/remove_item_from_cart_request.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/create_orders_response/create_orders_response.dart';
import 'package:haruviet/data/reponsitory/respone_general.dart';
import 'package:haruviet/data/reponsitory/shipment/payment_response/payment_response.dart';

import 'models/check_order_price_response/check_order_price_response.dart';
import 'models/get_cart_order_response/get_cart_order_response.dart';
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

  // start get user order from server
  Future<List<GetCartOrderResponse>> getCartOrderRP() async {
    try {
      final response = await _cartOrderService.getCartOrder();
      final result = GetCartOrderResponse.fromJsonArray(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return [];
  }
  // end get user order from server

  //
  Future<GetCartOrderResponse> removeItemFromCartRP(
      {required RemoveItemFromCartRequest request}) async {
    try {
      final response =
          await _cartOrderService.removeItemFromCart(request: request);
      final result = GetCartOrderResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GetCartOrderResponse();
  }

  Future<GeneralResponse> addItemToCartRP({
    required AddProductsRequest request,
  }) async {
    try {
      final response = await _cartOrderService.addItemToCart(request: request);
      final result = GeneralResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GeneralResponse();
  }

  // update

  Future<GeneralResponse> updateCartOrderRP({
    required RemoveItemFromCartRequest request,
  }) async {
    try {
      final response =
          await _cartOrderService.updateCartOrder(request: request);
      final result = GeneralResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GeneralResponse();
  }

  // create order

  Future<CreateOrdersResponse> createOrdersRP({
    required CreateOrderRequest request,
  }) async {
    try {
      final response = await _cartOrderService.createOrders(request: request);
      final result = CreateOrdersResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return CreateOrdersResponse();
  }

// checkShippingFee
  Future<PaymentResponse> checkShippingFeeRP({
    required CheckShippingFeeRequest request,
  }) async {
    try {
      final response =
          await _cartOrderService.checkShippingFee(request: request);
      final result = PaymentResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return PaymentResponse();
  }
}
