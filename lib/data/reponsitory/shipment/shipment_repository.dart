import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/shipment/models/shipment_request/shipment_request.dart';
import 'package:haruviet/api/services/shipment/shipment_services.dart';

import 'models/shipment_response/shipment_response.dart';

class ShipmentRepository {
  final _shipmentService = ShipmentService();

  Future<ShipmentResponse> shipmentFeeRP(
      {required ShipmentRequest request}) async {
    try {
      final response = await _shipmentService.shipmentFeeSV(request: request);
      final result = ShipmentResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return ShipmentResponse();
  }
}
