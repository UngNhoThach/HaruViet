class CartOrderVoucherParams {
  CartOrderVoucherParams({
    required this.totalPrice,
    required this.discountAmount,
    required this.codeSelected,
    required this.voucherMethodFuc,
  });
  final int totalPrice;
  final int discountAmount;
  final String codeSelected;
  final void Function({
    required String codeSelected,
    required int totalPrice,
    required int discountAmount,
  }) voucherMethodFuc;
}
