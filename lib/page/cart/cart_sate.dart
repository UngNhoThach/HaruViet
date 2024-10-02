import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/api/services/cart_orders/models/check_order_price_request/attribute_check_price.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/check_order_price_response/check_order_price_response.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/data/reponsitory/product/models/product_response.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:haruviet/page/cart/models/cart_item_request.dart';

part 'cart_sate.g.dart';

@CopyWith()
class CartState extends BaseState {
  final List<AttributeCheckPrice?> attributeCheckPrice;
  final List<CheckOrderPriceResponse?> checkOrderPriceResponse;
  final bool isLoading;
  final bool isValueDefault;
  final List<DataProductDetailResponse?>? listGiftProduct;
  final bool isFreeShipping;
  final int discountOrder;
  final int discountDetail;
  final int weight;
  final bool isSubmitSuccess;
  final List<CartModelProduct> productsList;
  final UserInfoLogin? userInfoLogin;
  final List<CartItemRequest> cartItemsRequest;
  final int? finalPrice;
  final int? finalPriceDefault;
  final int? totalItem;
  final List<ProductResponse> listCategories;
  final bool checkValue;
  const CartState({
    ViewState viewState = ViewState.loaded,
    this.attributeCheckPrice = const [],
    this.discountOrder = 0,
    this.discountDetail = 0,
    this.cartItemsRequest = const [],
    this.isFreeShipping = false,
    this.userInfoLogin,
    String errorMsg = '',
    this.listGiftProduct = const [],
    this.checkOrderPriceResponse = const [],
    this.productsList = const [],
    this.isSubmitSuccess = false,
    this.totalItem,
    this.weight = 0,
    this.checkValue = false,
    this.isValueDefault = false,
    this.finalPrice,
    this.finalPriceDefault,
    this.isLoading = false,
    this.listCategories = const [],
  }) : super(viewState, errorMsg);

  // bool get isValidPassWord {
  //   return rePasswordChange == passwordChange;
  // }
}
