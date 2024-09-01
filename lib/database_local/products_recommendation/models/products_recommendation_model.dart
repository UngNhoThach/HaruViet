import 'dart:convert';

import 'package:haruviet/data/reponsitory/product/models/brand.dart';
import 'package:haruviet/data/reponsitory/product/models/category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/product_promotion_price_list.dart';
import 'package:haruviet/data/reponsitory/product/models/price.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/price_promotion_list.dart';
import 'package:haruviet/data/reponsitory/product/models/supplier.dart';
import 'package:haruviet/data/reponsitory/product/models/images_product.dart';

const String productsTable = 'products';

class ProductRecommendationModel {
  final String id;
  final String sku;
  final String image;
  final Brand brand;
  final Supplier supplier;
  final Price price;
  final String cost;
  final int stock;
  final int sold;
  final int minimum;
  final String? weightClass;
  final String weight;
  final int kind;
  final String taxId;
  final int approve;
  final int sort;
  final int view;
  final String? dateLastview;
  final String? dateAvailable;
  // final List<Description> descriptions;
  final List<Category> categories;
  final List<ImagesProduct> images;
  final ProductPromotionPriceList? discount;

  ProductRecommendationModel({
    required this.id,
    required this.sku,
    required this.image,
    required this.brand,
    required this.supplier,
    required this.price,
    required this.cost,
    required this.stock,
    required this.sold,
    required this.minimum,
    this.weightClass,
    required this.weight,
    required this.kind,
    required this.taxId,
    required this.approve,
    required this.sort,
    required this.view,
    this.dateLastview,
    this.dateAvailable,
    //  required this.descriptions,
    required this.categories,
    required this.images,
    this.discount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sku': sku,
      'image': image,
      'brand': json.encode(brand.toJson()),
      'supplier': json.encode(supplier.toJson()),
      'price': json.encode(price.toJson()),
      'cost': cost,
      'stock': stock,
      'sold': sold,
      'minimum': minimum,
      'weightClass': weightClass,
      'weight': weight,
      'kind': kind,
      'taxId': taxId,
      'approve': approve,
      'sort': sort,
      'view': view,
      'dateLastview': dateLastview,
      'dateAvailable': dateAvailable,
      //  'descriptions': json.encode(descriptions.map((d) => d.toJson()).toList()),
      'categories': json.encode(categories.map((c) => c.toJson()).toList()),
      'images': json.encode(images.map((c) => c.toJson()).toList()),
      'promotionPrice': json.encode(discount?.toJson()),
    };
  }

  factory ProductRecommendationModel.fromMap(Map<String, dynamic> map) {
    return ProductRecommendationModel(
      id: map['id'],
      sku: map['sku'],
      image: map['image'],
      brand: Brand.fromJson(json.decode(map['brand'])),
      supplier: Supplier.fromJson(json.decode(map['supplier'])),
      price: Price.fromJson(json.decode(map['price'])),
      cost: map['cost'],
      stock: map['stock'],
      sold: map['sold'],
      minimum: map['minimum'],
      weightClass: map['weightClass'],
      weight: map['weight'],
      kind: map['kind'],
      taxId: map['taxId'],
      approve: map['approve'],
      sort: map['sort'],
      view: map['view'],
      dateLastview: map['dateLastview'],
      dateAvailable: map['dateAvailable'],
      // descriptions: List<Description>.from(
      //     json.decode(map['descriptions']).map((x) => Description.fromJson(x))),
      categories: List<Category>.from(
          json.decode(map['categories']).map((x) => Category.fromJson(x))),
      images: List<ImagesProduct>.from(json.decode(map['images']).map((x) =>
          ImagesProduct.fromJson(
              x))), // List<ImagesProduct>.from(json.decode(map['images'])),
      discount: ProductPromotionPriceList.fromJson(
          json.decode(map['promotionPrice'])), // map['promotionPrice'],
    );
  }

  factory ProductRecommendationModel.fromDataProduct(DataProduct product) {
    return ProductRecommendationModel(
        id: product.id ?? '',
        sku: product.sku ?? '',
        image: product.image ?? '',
        brand: product.brand ?? Brand(id: '', name: ''),
        supplier: product.supplier ?? Supplier(id: '', name: ''),
        price: product.price ??
            Price(price: 0, priceStr: '', exchangeRate: 0, currency: ''),
        cost: product.cost ?? '',
        stock: product.stock ?? 0,
        sold: product.sold ?? 0,
        minimum: product.minimum ?? 0,
        weightClass: product.weightClass,
        weight: product.weight ?? '',
        kind: product.kind ?? 0,
        taxId: product.taxId ?? '',
        approve: product.approve ?? 0,
        sort: product.sort ?? 0,
        view: product.view ?? 0,
        dateLastview: product.dateLastview,
        dateAvailable: product.dateAvailable,
        //       descriptions: product.descriptions ?? [],
        categories: product.categories ?? [],
        images: product.images ?? [],
        discount: product.discount ??
            ProductPromotionPriceList(
                dateEnd: '',
                dateStart: '',
                pricePromotion: PricePromotion(
                    currency: '', exchangeRate: 0, price: 0, priceStr: ''),
                percent: 0));
  }

  DataProduct toDataProduct() {
    return DataProduct(
      id: id,
      sku: sku,
      image: image,
      brand: brand,
      supplier: supplier,
      price: price,
      cost: cost,
      stock: stock,
      sold: sold,
      minimum: minimum,
      weightClass: weightClass,
      weight: weight,
      kind: kind,
      taxId: taxId,
      approve: approve,
      sort: sort,
      view: view,
      dateLastview: dateLastview,
      dateAvailable: dateAvailable,
      //     descriptions: descriptions,
      categories: categories,
      images: images,
      discount: discount,
    );
  }
}
