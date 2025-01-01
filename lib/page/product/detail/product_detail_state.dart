import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/attributes_product_detail/attributes_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:haruviet/helper/const.dart';

part 'product_detail_state.g.dart';

@CopyWith()
class ProductDetailState extends BaseState {
  final String? message;
  final Map<String, dynamic>? optionsSelected;
  final int productStoreDefault;
  final bool isSubmitSuccess;
  final bool isLoginsSuccess;
  final List<ValueOptionProduct>? attributesDropdown;
  final bool isLoading;
  final DataProduct? dataProduct;
  final List<String> imageUrls;
  final int? totalProductInCart;
  final List<CartModelProduct> productsList;
  final CartProviderV2? cart;
  final bool checkProductInCart;
  final bool checkProductAttributes;
  final String? sizeSelected;
  final Color? colorSelected;
  final int currentCounter;
  final bool isSoldOut;
  final bool changePopUp;
  final List<DataProduct> datatListBrand;
  final List<DataProduct> newDataListBrand;
  final List<DataProduct> datatList;
  final List<DataProduct> newDataList;
  final bool canLoadMore;
  final bool canLoadMoreRecommendationProduct;

  final int limit;
  final int currentPage;
  final List<Option?> options;
  final List<AttributesProductDetail?> attributes;
  final bool isSelected;
  final List<bool> isValid;
  final Map<String, dynamic>? dataDetail;
  final Map<String, dynamic>? technical;
  final String? idCategory;
  final String? htmlData;
  final List<DataProduct> productsListRecommendations;
  final String? nameCategory;
  final bool isLoadingProductBrand;
  final bool isLoadingProductCategory;
  final bool isLoadingProductRecommendation;

  const ProductDetailState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.message,
    this.htmlData,
    this.isLoadingProductRecommendation = false,
    this.isLoadingProductBrand = false,
    this.isLoadingProductCategory = false,
    this.datatListBrand = const [],
    this.newDataListBrand = const [],
    this.productsListRecommendations = const [],
    this.nameCategory,
    this.optionsSelected,
    this.technical,
    this.idCategory,
    this.dataDetail,
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
    this.limit = perPage,
    this.isSoldOut = false,
    this.isLoginsSuccess = false,
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.datatList = const [],
    this.options = const [],
    this.attributes = const [],
    this.newDataList = const [],
    this.imageUrls = const [],
    this.productsList = const [],
    this.canLoadMore = false,
    this.canLoadMoreRecommendationProduct = false,
    this.dataProduct,
  }) : super(viewState, errorMsg);
}
