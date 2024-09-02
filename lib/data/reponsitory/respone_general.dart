import 'package:json_annotation/json_annotation.dart';
import 'cart_orders/models/cart_order_response/data_cart_response.dart';
import 'cart_orders/models/cart_order_status_response/data_status_order.dart';
import 'category/models/list_category_response/data_category.dart';
import 'product/models/data_list_product/data_product_list.dart';

part 'respone_general.g.dart';

@JsonSerializable()
class GeneralResponse {
  @JsonKey(name: 'current_page')
  int? currentPage;
  int? from;
  @JsonKey(name: 'last_page')
  int? lastPage;
  String? path;
  @JsonKey(name: 'per_page')
  int? perPage;
  int? to;
  int? total;
  List<dynamic>? data;

  GeneralResponse({
    this.currentPage,
    this.data,
    this.from,
    this.path,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return _$GeneralResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GeneralResponseToJson(this);

  /// Method to parse `data` as List<DataCart>
  List<DataCart>? parseDataCart() {
    if (data != null && data!.isNotEmpty) {
      return data!
          .map((e) => DataCart.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Method to parse `data` as List<DataStatusOrder>
  List<DataStatusOrder>? parseDataStatusOrder() {
    if (data != null && data!.isNotEmpty) {
      return data!
          .map((e) => DataStatusOrder.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Method to parse `data` as List<DataCategory>
  List<DataCategory>? parseDataCategory() {
    if (data != null && data!.isNotEmpty) {
      return data!
          .map((e) => DataCategory.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Method to parse `data` as List<DataProduct>
  List<DataProduct>? parseDataProduct() {
    if (data != null && data!.isNotEmpty) {
      return data!
          .map((e) => DataProduct.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
