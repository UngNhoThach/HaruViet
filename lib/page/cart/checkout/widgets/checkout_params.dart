class CheckoutParams {
  CheckoutParams({
    this.price,
    required this.discountOrder,
    required this.weight,
  });
  final String? price;
  final int discountOrder;
  final int weight;
}
