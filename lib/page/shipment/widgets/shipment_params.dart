import 'package:haruviet/data/reponsitory/shipment/models/shipment_response/shipment_response.dart';

class ShipmentParams {
  ShipmentParams({
    required this.shipmentResponse,
    this.shipmenFunc,
    required this.shippingAddress,
    required this.totalPrice,
    required this.titleSelected,
    required this.weight,
    required this.selectedShipment,
    this.selectShipmentFunc,
  });
  final ShipmentResponse shipmentResponse;
  final void Function(ShipmentResponse?, String)? shipmenFunc;
  final List<String> shippingAddress;
  final int totalPrice;
  final double weight;
  final int selectedShipment;
  final String titleSelected;
  final void Function(int?)? selectShipmentFunc;
}
