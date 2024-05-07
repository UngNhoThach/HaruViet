import 'package:eco_app/page/core/product_data.dart';
import 'package:eco_app/page/product/models/product_size.dart';

enum ProductType { all, watch, mobile, headphone, tablet, tv }

class Product {
  String name;
  int price;
  int? off;
  String about;
  bool isAvailable;
  ProductSizeType? sizes;
  int _quantity;
  List<String> images;
  bool isFavorite;
  double rating;
  ProductType type;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Product({
    this.sizes,
    this.about = AppData.dummyText,
    required this.name,
    required this.price,
    required this.isAvailable,
    required this.off,
    required int quantity,
    required this.images,
    required this.isFavorite,
    required this.rating,
    required this.type,
  }) : _quantity = quantity;
}
