import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/database_local/product/models/cart_model.dart';
import 'package:haruviet/helper/const.dart';

part 'product_detail_state.g.dart';

@CopyWith()
class ProductDetailState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  final DataProductDetailResponse? dataProduct;
  final List<String> imageUrls;
  final int? totalProductInCart;
  final List<Products> productsList;
  final CartProvider? cart;
  final bool checkProductInCart;
  final bool checkProductAttributes;
  final String? sizeSelected;
  final String? colorSelected;
  final int? currentCounter;
  final bool validBuyProductAttributes;
  final bool changePopUp;
  final List<DataProduct> datatList;
  final List<DataProduct> newDataList;
  final bool canLoadMore;
  final int limit;
  final int currentPage;

  const ProductDetailState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.cart,
    this.sizeSelected,
    this.colorSelected,
    this.currentCounter,
    this.currentPage = startPage,
    this.changePopUp = false,
    this.checkProductInCart = false,
    this.checkProductAttributes = false,
    this.totalProductInCart,
    this.limit = perPageHome,
    this.validBuyProductAttributes = false,
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.datatList = const [],
    this.newDataList = const [],
    this.imageUrls = const [],
    this.productsList = const [],
    this.canLoadMore = false,
    this.dataProduct,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
