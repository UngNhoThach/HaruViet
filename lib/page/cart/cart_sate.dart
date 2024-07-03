import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/product/models/product_response.dart';
import 'package:eco_app/database_local/product/models/cart_model.dart';
import 'package:eco_app/page/cart/models/cart_item_request.dart';

part 'cart_sate.g.dart';

@CopyWith()
class CartState extends BaseState {
  final bool isLoading;
  final bool isValueDefault;
  final bool isSubmitSuccess;
  final List<Products> productsList;

  final List<CartItemRequest> cartItemsRequest;
  final int? finalPrice;
  final int? finalPriceDefault;
  final int? totalItem;
  final List<ProductResponse> listCategories;
  final bool checkValue;
  const CartState({
    ViewState viewState = ViewState.loaded,
    this.cartItemsRequest = const [],
    String errorMsg = '',
    this.productsList = const [],
    this.isSubmitSuccess = false,
    this.totalItem,
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
