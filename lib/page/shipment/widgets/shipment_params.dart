import '../../../data/reponsitory/shipment/payment_response/data_payment.dart';

class ShipmentParams {
  ShipmentParams({
    this.data,
    this.selectShipmentFunc,
    required this.selectedItemShipment,
  });
  final List<DataPayment>? data;
  final DataPayment selectedItemShipment;
  final void Function(DataPayment? dataPayment)? selectShipmentFunc;
}
