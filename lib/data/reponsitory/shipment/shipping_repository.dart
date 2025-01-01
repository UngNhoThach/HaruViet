import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/shipment/shipping_services.dart';
import 'package:haruviet/data/reponsitory/shipment/models/payment_response/payment_response.dart';
import 'package:haruviet/data/reponsitory/shipment/models/shipping_response/shipping_response.dart';

class ShippingRepository {
  final _shippingService = ShippingServices();

  Future<ShippingResponse> shippingMethods() async {
    try {
      final response = await _shippingService.shippingMethodsSV();
      final result = ShippingResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return ShippingResponse();
  }

  Future<PaymentResponse> paymentMethods() async {
    try {
      final response = await _shippingService.paymentMethodsSV();
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
