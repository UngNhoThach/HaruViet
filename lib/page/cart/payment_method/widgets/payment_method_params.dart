class PaymentMethodParams {
  PaymentMethodParams({
    this.indexShippingMethod,
    this.shippingMethodFuc,
  });
  final int? indexShippingMethod;
  final void Function(String? valueShippingMethod, int? indexShippingMethod)?
      shippingMethodFuc;
}
