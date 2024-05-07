import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/product/product_response.dart';
import 'package:eco_app/page/cart/models/cart_item_request.dart';

part 'support_sate.g.dart';

@CopyWith()
class SupportState extends BaseState {
  final bool isLoading;
  final List<CartItemRequest> cartItemsRequest;
  final int? finalPrice;
  final int? totalItem;
  final List<ProductResponse> listCategories;
  const SupportState({
    ViewState viewState = ViewState.loaded,
    this.cartItemsRequest = const [],
    String errorMsg = '',
    this.totalItem,
    this.finalPrice,
    this.isLoading = false,
    this.listCategories = const [],
  }) : super(viewState, errorMsg);

  // bool get isValidPassWord {
  //   return rePasswordChange == passwordChange;
  // }
}
