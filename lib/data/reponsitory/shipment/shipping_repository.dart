import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/shipment/shipping_services.dart';

import 'payment_response/payment_response.dart';

class ShippingRepository {
  final _shippingService = ShippingServices();

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
