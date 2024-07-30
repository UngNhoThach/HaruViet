import 'package:flutter/foundation.dart' show ValueNotifier, immutable;

const String cartTable = 'cart';

class CartModel {
  static final List<String> values = [
    id,
    nameProduct,
    description,
    totalQuantity,
    isCompleted,
    idProduct,
    priceProduct,
    brandProduct,
    imageProduct,
  ];

  // Column names for Products tables
  static const id = 'id';
  static const nameProduct = 'nameProduct';
  static const description = 'description';
  static const totalQuantity = 'totalQuantity';
  static const isCompleted = 'isCompleted';
  static const idProduct = 'idProduct';
  static const priceProduct = 'priceProduct';
  static const brandProduct = 'brandProduct';
  static const imageProduct = 'imageProduct';
}

@immutable
class Products {
  final int? id;
  final String nameProduct;
  final String description;
  final ValueNotifier<int> totalQuantity;
  final bool isCompleted;
  final String idProduct;
  final String priceProduct;
  final String brandProduct;
  final String imageProduct;

  const Products({
    this.id,
    required this.nameProduct,
    required this.description,
    required this.totalQuantity,
    required this.isCompleted,
    required this.idProduct,
    required this.priceProduct,
    required this.brandProduct,
    required this.imageProduct,
  });

  Products copy({
    int? id,
    String? nameProduct,
    String? description,
    ValueNotifier<int>? totalQuantity,
    bool? isCompleted,
    String? idProduct,
    String? priceProduct,
    String? brandProduct,
    String? imageProduct,
  }) =>
      Products(
        id: id ?? this.id,
        nameProduct: nameProduct ?? this.nameProduct,
        description: description ?? this.description,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        isCompleted: isCompleted ?? this.isCompleted,
        idProduct: idProduct ?? this.idProduct,
        priceProduct: priceProduct ?? this.priceProduct,
        brandProduct: brandProduct ?? this.brandProduct,
        imageProduct: brandProduct ?? this.imageProduct,
      );

  Map<String, dynamic> toMap() => {
        CartModel.id: id,
        CartModel.nameProduct: nameProduct,
        CartModel.description: description,
        CartModel.totalQuantity: totalQuantity.value,
        CartModel.isCompleted: isCompleted ? 1 : 0,
        CartModel.idProduct: idProduct,
        CartModel.priceProduct: priceProduct,
        CartModel.brandProduct: brandProduct,
        CartModel.imageProduct: imageProduct,
      };

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map[CartModel.id] as int?,
      nameProduct: map[CartModel.nameProduct] as String,
      description: map[CartModel.description] as String,
      totalQuantity: ValueNotifier<int>(map[CartModel.totalQuantity] as int),
      isCompleted: (map[CartModel.isCompleted] as int) == 1,
      idProduct: map[CartModel.idProduct] as String,
      priceProduct: map[CartModel.priceProduct] as String,
      brandProduct: map[CartModel.brandProduct] as String,
      imageProduct: map[CartModel.imageProduct] as String,
    );
  }
}
