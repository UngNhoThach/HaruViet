import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/attributes_product_detail/attributes_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/helper/const.dart';

part 'product_detail_state.g.dart';

@CopyWith()
class ProductDetailState extends BaseState {
  final int productStoreDefault;
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final List<ValueOptionProduct>? attributesDropdown;
  final bool isLoading;
  final DataProductDetailResponse? dataProduct;
  final List<String> imageUrls;
  final int? totalProductInCart;
  final List<DataProductDetailResponse> productsList;
  final CartProviderV2? cart;
  final bool checkProductInCart;
  final bool checkProductAttributes;
  final String? sizeSelected;
  final Color? colorSelected;
  final int currentCounter;
  final bool isSoldOut;
  final bool changePopUp;
  final List<DataProduct> datatList;
  final List<DataProduct> newDataList;
  final bool canLoadMore;
  final int limit;
  final int currentPage;
  final List<Option?> options;
  final List<AttributesProductDetail?> attributes;
  final bool isSelected;
  final List<bool> isValid;

  const ProductDetailState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.cart,
    this.productStoreDefault = 0,
    this.isValid = const [],
    this.sizeSelected,
    this.attributesDropdown,
    this.colorSelected,
    this.currentCounter = 1,
    this.currentPage = startPage,
    this.changePopUp = false,
    this.checkProductInCart = false,
    this.isSelected = false,
    this.checkProductAttributes = false,
    this.totalProductInCart,
    this.limit = perPageHome,
    this.isSoldOut = false,
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.datatList = const [],
    this.options = const [],
    this.attributes = const [],
    this.newDataList = const [],
    this.imageUrls = const [],
    this.productsList = const [],
    this.canLoadMore = false,
    this.dataProduct,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
