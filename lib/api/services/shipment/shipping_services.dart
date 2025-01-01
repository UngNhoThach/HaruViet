import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';

class ShippingServices extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');

  // start service shipping method
  Future<Response> shippingMethodsSV() async {
    try {
      final response = await get(
        ShippingApi.shippingMethods,
      );

      // Check if the response is null or has no data
      if (response == null) {
        throw Exception("Received null response from shipment service");
      }

      return response;
    } catch (error) {
      if (kDebugMode) {
        print("Error during shipment fee request: $error");
      }

      throw Exception("Error fetching shipment fee");
    }
  }
  // end service shipping method

  // start service payment method
  Future<Response> paymentMethodsSV() async {
    try {
      final response = await get(
        ShippingApi.paymentMethods,
      );

      // Check if the response is null or has no data
      if (response == null) {
        throw Exception("Received null response from shipment service");
      }

      return response;
    } catch (error) {
      if (kDebugMode) {
        print("Error during shipment fee request: $error");
      }

      throw Exception("Error fetching shipment fee");
    }
  }
  // end service payment method
}
