import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/product/models/list_product/data_product.dart';
import 'package:eco_app/data/data_local/user_state.dart';
import 'package:eco_app/database_local/product/cart_provider.dart';
import 'package:eco_app/database_local/product/models/cart_model.dart';

part 'product_detail_state.g.dart';

@CopyWith()
class ProductDetailState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  final DataProduct? dataProduct;
  final List<String> imageUrls;
  final int? totalProductInCart;
  final List<Products> productsList;
  final CartProvider? cart;
  final bool checkProductInCart;
  final bool checkProductAttributes;
  final String? sizeSelected;
  final String? colorSelected;

  const ProductDetailState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.cart,
    this.sizeSelected,
    this.colorSelected,
    this.checkProductInCart = false,
    this.checkProductAttributes = false,
    this.totalProductInCart,
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.imageUrls = const [],
    this.productsList = const [],
    this.dataProduct,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);

  bool get isValidBuyProductAttributes {
    return sizeSelected != null && colorSelected != null;
  }
}
