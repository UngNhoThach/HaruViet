import 'dart:convert';

import 'package:haruviet/data/reponsitory/cart_orders/models/get_cart_order_response/get_cart_order_response.dart';
import 'package:haruviet/data/reponsitory/product/models/brand.dart';
import 'package:haruviet/data/reponsitory/product/models/category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/price_promotion_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/product_promotion_price_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/promotiondetail_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/reviews_response/ratings_count.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/reviews_response/reviews_response.dart';
import 'package:haruviet/data/reponsitory/product/models/images_product.dart';
import 'package:haruviet/data/reponsitory/product/models/price.dart';
import 'package:haruviet/data/reponsitory/product/models/product_description.dart';
import 'package:haruviet/data/reponsitory/product/models/supplier.dart';

const String cartTable = 'cartOrder';

class CartModelProduct {
  //start add the product with response data

  //end add the product with response data
  final List<Option?>? options;
  final String id;
  final String sku;
  final String image;
  final Brand brand;
  final Supplier supplier;
  final Price price;
  final String cost;
  final int stock;
  final int sold;
  int totalQuantity;
  final double totalPriceItem;
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
  final ProductDescription descriptions;
  final List<Category> categories;
  final List<ImagesProduct> images;
  final List<Promotiondetail?>? promotiondetails;
  final ReviewsResponse? reviews;
  final ProductPromotionPriceList? discount;

  CartModelProduct({
    this.discount,
    required this.id,
    this.options,
    this.promotiondetails,
    this.reviews,
    required this.totalPriceItem,
    required this.sku,
    required this.image,
    required this.brand,
    required this.supplier,
    required this.price,
    required this.cost,
    required this.stock,
    required this.totalQuantity,
    required this.sold,
    required this.minimum,
    required this.descriptions,
    this.weightClass,
    required this.weight,
    required this.kind,
    required this.taxId,
    required this.approve,
    required this.sort,
    required this.view,
    this.dateLastview,
    this.dateAvailable,
    required this.categories,
    required this.images,
    //  this.discount,
  });

  // CopyWith method
  CartModelProduct copy({
    List<Option?>? options,
    String? id,
    String? sku,
    String? image,
    Brand? brand,
    Supplier? supplier,
    Price? price,
    String? cost,
    int? stock,
    int? sold,
    ProductPromotionPriceList? discount,
    int? discountDetail,
    int? totalQuantity,
    double? totalPriceItem,
    int? minimum,
    String? weightClass,
    String? weight,
    int? kind,
    String? taxId,
    int? approve,
    int? sort,
    int? view,
    String? dateLastview,
    String? dateAvailable,
    ProductDescription? descriptions,
    List<Category>? categories,
    List<ImagesProduct>? images,
    List<Promotiondetail?>? promotiondetails,
    ReviewsResponse? reviews,
  }) =>
      CartModelProduct(
        discount: discount ?? this.discount,
        promotiondetails: promotiondetails ?? this.promotiondetails,
        reviews: reviews ?? this.reviews,
        options: options ?? this.options,
        id: id ?? this.id,
        totalPriceItem: totalPriceItem ?? this.totalPriceItem,
        sku: sku ?? this.sku,
        image: image ?? this.image,
        brand: brand ?? this.brand,
        supplier: supplier ?? this.supplier,
        price: price ?? this.price,
        cost: cost ?? this.cost,
        stock: stock ?? this.stock,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        sold: sold ?? this.sold,
        minimum: minimum ?? this.minimum,
        descriptions: descriptions ?? this.descriptions,
        weightClass: weightClass ?? this.weightClass,
        weight: weight ?? this.weight,
        kind: kind ?? this.kind,
        taxId: taxId ?? this.taxId,
        approve: approve ?? this.approve,
        sort: sort ?? this.sort,
        view: view ?? this.view,
        dateLastview: dateLastview ?? this.dateLastview,
        dateAvailable: dateAvailable ?? this.dateAvailable,
        categories: categories ?? this.categories,
        images: images ?? this.images,
      );
  Map<String, dynamic> toMap() {
    return {
      'discount': json.encode(discount?.toJson()),
      'promotiondetails': json.encode(promotiondetails
          ?.where((e) => e != null)
          .map((e) => e!.toJson())
          .toList()),
      'reviews': json.encode(reviews?.toJson()),
      'options': json.encode(options?.map((e) => e?.toJson()).toList()),
      'id': id,
      'sku': sku,
      'totalPriceItem': totalPriceItem,
      'totalQuantity': totalQuantity,
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
      'descriptions': json.encode(descriptions.toJson()),
      'categories': json.encode(categories.map((c) => c.toJson()).toList()),
      'images': json.encode(images.map((c) => c.toJson()).toList()),
    };
  }

  factory CartModelProduct.fromMap(Map<String, dynamic> map) {
    return CartModelProduct(
      discount:
          ProductPromotionPriceList.fromJson(json.decode(map['discount'])),
      promotiondetails: List<Promotiondetail>.from(json
          .decode(map['promotiondetails'])
          .map((x) => Promotiondetail.fromJson(x))),
      reviews: ReviewsResponse.fromJson(json.decode(map['reviews'])),
      totalPriceItem: map['totalPriceItem'],
      descriptions:
          ProductDescription.fromJson(json.decode(map['descriptions'])),
      id: map['id'],
      options: List<Option>.from(
          json.decode(map['options']).map((x) => Option.fromJson(x))),
      sku: map['sku'],
      totalQuantity: map['totalQuantity'],
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
      categories: List<Category>.from(
          json.decode(map['categories']).map((x) => Category.fromJson(x))),
      images: List<ImagesProduct>.from(json.decode(map['images']).map((x) =>
          ImagesProduct.fromJson(
              x))), // List<ImagesProduct>.from(json.decode(map['images'])),
    );
  }

  // start convert data from DataProduct to CartModelProduct STORED LOCAL
  factory CartModelProduct.fromDataProduct(DataProduct product) {
    return CartModelProduct(
      discount: product.discount ??
          ProductPromotionPriceList(
            dateEnd: '',
            dateStart: '',
            percent: 0.0,
            pricePromotion: PricePromotion(
                currency: '', exchangeRate: 0, price: 0, priceStr: ''),
          ),
      promotiondetails: product.promotiondetails ?? [],
      reviews: product.reviews ??
          ReviewsResponse(
            averageRating: 0,
            data: [],
            ratingsCount: RatingsCount(
              star1: 0,
              star2: 0,
              star3: 0,
              star4: 0,
              star5: 0,
            ),
            totalReviews: 0,
          ),
      options: product.options ?? [],
      totalPriceItem: product.totalPriceItem ?? 0.0,
      descriptions: product.descriptions ??
          ProductDescription(
              content: '',
              description: '',
              keyword: '',
              lang: '',
              name: '',
              productId: '',
              title: ''),
      totalQuantity: product.totalQuantity ?? 1,
      id: product.id ?? '',
      sku: product.sku ?? '',
      image: product.image ?? '',
      brand: product.brand ?? Brand(id: '', name: ''),
      supplier: product.supplier ?? Supplier(id: '', name: ''),
      price: product.price ??
          Price(
              totalQuantity: 0,
              price: 0,
              priceStr: '',
              exchangeRate: 0,
              currency: '',
              discountDetail: 0),
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
      categories: product.categories ?? [],
      images: product.images ?? [],
    );
  }

  DataProduct toDataProduct() {
    return DataProduct(
      promotiondetails: promotiondetails,
      reviews: reviews,
      options: options,
      id: id,
      totalQuantity: totalQuantity,
      sku: sku,
      image: image,
      discount: discount,
      brand: brand,
      totalPriceItem: totalPriceItem,
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
      descriptions: descriptions,
      categories: categories,
      images: images,
    );
  }
  // end convert data from DataProduct to CartModelProduct STORED LOCAL

  // start convert data from GetCartOrderResponse to CartModelProduct STORED LOCAL
  factory CartModelProduct.fromCartOrderResponse(GetCartOrderResponse product) {
    return CartModelProduct(
      //  unknown data discount
      discount: ProductPromotionPriceList(
        dateEnd: '',
        dateStart: '',
        percent: 0.0,
        pricePromotion: PricePromotion(
            currency: '', exchangeRate: 0, price: 0, priceStr: ''),
      ),

      //  unknown data promotiondetails
      promotiondetails: [],

      //  unknown data reviews
      reviews: ReviewsResponse(
        averageRating: 0,
        data: [],
        ratingsCount: RatingsCount(
          star1: 0,
          star2: 0,
          star3: 0,
          star4: 0,
          star5: 0,
        ),
        totalReviews: 0,
      ),

      //  unknown data options
      options: [],

      totalPriceItem: product.subtotal?.toDouble() ?? 0.0,

      //  unknown data descriptions
      descriptions: ProductDescription(
          content: '',
          description: '',
          keyword: '',
          lang: '',
          name: '',
          productId: '',
          title: ''),

      totalQuantity: product.qty ?? 1,
      id: product.id ?? '',

      //  unknown data sku
      sku: '',
      image: product.image ?? '',

      //  unknown data brand
      brand: Brand(id: '', name: ''),

      //  unknown data supplier
      supplier: Supplier(id: '', name: ''),
      price: product.price != null
          ? Price(
              totalQuantity: product.qty,
              price: product.price,
              priceStr: '',
              exchangeRate: 0,
              currency: '',
              discountDetail: product.attributes?.discountDetail)
          : Price(
              totalQuantity: 0,
              price: 0,
              priceStr: '',
              exchangeRate: 0,
              currency: '',
              discountDetail: 0),

      // unknown data cost
      cost: '',

      // unknown data stock
      stock: 0,

      // unknown data sold
      sold: 0,

      // unknown data minimum
      minimum: 0,

      // unknown data weightClass
      weightClass: '',

      // unknown data weight
      weight: '',

      // unknown data kind
      kind: 0,

      // unknown data taxId
      taxId: '',

      // unknown data approve
      approve: 0,

      // unknown data sort
      sort: 0,

      // unknown data view
      view: 0,

      // unknown data dateLastview
      dateLastview: '',

      // unknown data dateAvailable
      dateAvailable: '',

      // unknown data categories
      categories: [],

      // unknown data id image
      images: product.image != null
          ? [
              ImagesProduct(
                  id: '', image: product.image ?? '', productId: product.id)
            ]
          : [],
    );
  }

  DataProduct toCartOrderResponse() {
    return DataProduct(
      promotiondetails: promotiondetails,
      reviews: reviews,
      options: options,
      id: id,
      totalQuantity: totalQuantity,
      sku: sku,
      image: image,
      discount: discount,
      brand: brand,
      totalPriceItem: totalPriceItem,
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
      descriptions: descriptions,
      categories: categories,
      images: images,
    );
  }
  // end convert data from GetCartOrderResponse to CartModelProduct STORED LOCAL
}
