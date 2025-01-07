import 'package:haruviet/data/reponsitory/shipment/payment_response/data_payment.dart';

class PaymentMethodParams {
  PaymentMethodParams({
    this.keyPaymentMethod,
    this.shippingMethodFuc,
    this.dataPayment,
    this.valueShipping,
  });
  final String? keyPaymentMethod;
  final String? valueShipping;
  final void Function(String? valueShippingMethod, String? keyPaymentMethod)?
      shippingMethodFuc;
  List<DataPayment>? dataPayment;
}
