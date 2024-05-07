class CartItemRequest {
  CartItemRequest({
    this.quality,
    this.price,
    this.totalPriceItem,
  });
  final int? quality;
  final int? price;
  final int? totalPriceItem;
  CartItemRequest copyWith({
    int? quality,
    int? price,
    int? totalPriceItem,
  }) {
    return CartItemRequest(
      quality: quality ?? this.quality,
      price: price ?? this.price,
      totalPriceItem: totalPriceItem ?? this.totalPriceItem,
    );
  }
}
