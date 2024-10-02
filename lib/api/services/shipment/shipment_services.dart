import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service_ghtk.dart';

import 'models/shipment_request/shipment_request.dart';

class ShipmentService extends BaseServiceGHTK {
  ApiHeaders apiHeaders = ApiHeaders('');
  Future<Response> shipmentFeeSV({
    required ShipmentRequest request,
  }) async {
    try {
      final response = await post(
        DeliveryApi.shipmentFee,
        data: request.toJson(),
        headers: apiHeaders.giaohangtietkiemHeaders,
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

      // Optionally, you can throw the error or return a default response.
      throw Exception("Error fetching shipment fee");
    }
  }
}
