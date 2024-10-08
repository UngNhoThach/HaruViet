import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/product/cart_database_v2.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/product/detail/product_detail_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/product_params.dart';
import 'package:provider/provider.dart';

// ProductDetailBloc
class ProductDetailBloc extends BaseBloc<ProductDetailState> {
  final BuildContext context;
  ProductDetailBloc(this.context) : super(const ProductDetailState());
  final ProductRepository _productRepository = ProductRepository();

  List<DataProductDetailResponse> productsList = [];
  ValueNotifier<int> counter = ValueNotifier<int>(1);

  int splitCurrency(String currency) {
    List<String> parts = currency.split('.');
    int wholePart = int.parse(parts[0]);
    return wholePart;
  }

  getData(
    final String idProduct,
    final String domain,
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final userInfoLogin = await Preference.getUserInfo();
      final productDetail =
          await _productRepository.getProductDetailsRP(idProduct: idProduct);

      // add images to list review
      final imageUrls = [
        '$domain${productDetail.image}',
      ];
      if (productDetail.images != null && productDetail.images!.isNotEmpty) {
        for (var element in productDetail.images!) {
          imageUrls.add('$domain${element.image ?? ''}');
        }
      }
      int totalItemInCart = (CartProviderV2().getCounter());
      productsList = await CartDatabaseV2().getAllProducts();

      final bool checkAttributes;
      final List<bool> isValid = [];

      if ((productDetail.options == null) || (productDetail.options!.isEmpty)) {
        checkAttributes = false;
      } else {
        checkAttributes = true;
        isValid.addAll(
            List.generate(productDetail.options!.length, (index) => false));
      }

      emit(state.copyWith(
        userInfoLogin: userInfoLogin,
        dataProduct: productDetail,
        isValid: isValid,
        productStoreDefault: productDetail.stock,
        attributes: productDetail.attributes,
        options: productDetail.options,
        totalProductInCart: totalItemInCart,
        productsList: productsList,
        imageUrls: imageUrls,
        checkProductAttributes: checkAttributes,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
    // for check isValid and fetch data
    onValidPopSelected();
    onFetch(page: startPage);

    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onReset() {
    // onFetch(page: startPage);
  }

  // product list
  onFetch({
    required int page,
  }) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMore: false,
          ),
        );
      }
      final productList = await _productRepository.getListProductsRP(
        request: GetListProductRequest(paegNumber: page, pageSize: state.limit),
      );

      final datatList = List<DataProduct>.from(state.datatList)
        ..addAll(productList.parseDataProduct() ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      final canLoadMore = page <= maxLoadMore;

      emit(state.copyWith(
        datatList: datatList,
        newDataList: productList.parseDataProduct(),
        currentPage: page,
        canLoadMore: canLoadMore,
      ));

      emit(state.copyWith(
        isLoading: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
  }

  int checkIndexProducts(String idProduct) {
    final productList = state.productsList;
    final index = productList.indexWhere((element) => element.id == idProduct);
    return index;
  }

  onAddItemToCart({
    required ProductParams productParams,
  }) async {
    var productList = state.productsList;
    final index = checkIndexProducts(productParams.dataProduct.id ?? '');
    final cart = Provider.of<CartProviderV2>(context, listen: false);

    // change quality
    productParams.dataProduct.totalQuantity = state.currentCounter;
    productParams.dataProduct.options = state.options;
    if (index == -1) {
      await CartDatabaseV2().insertProductFromDataProduct(
        productParams.dataProduct,
      );
      productList.add(productParams.dataProduct);
      cart.addCounter();
      // cart.addTotalPrice(productParams.dataProduct.price!.price!.toDouble());
      //  cart.addListener(() { })
    } else {
      // sản phẩm đã tồn tại trong giỏ hàng
      emit(state.copyWith(checkProductInCart: true));
    }
    emit(state.copyWith(productsList: productList));
    emit(state.copyWith(checkProductInCart: false));
  }

// popup check
  onHandleCounterChanged(int newCounter) {
    if (newCounter >= 1) {
      emit(state.copyWith(currentCounter: newCounter));
    } else {
      emit(state.copyWith(currentCounter: 1));
    }
    onValidPopSelected();
  }

  onValidPopSelected() {
    bool check = true;
    final tempCheck = List.from(state.isValid)
        .firstWhere((element) => element == false, orElse: () => true);
    if (tempCheck == true && state.currentCounter < state.productStoreDefault) {
      check = false;
    }
    emit(state.copyWith(
      isSoldOut: check,
    ));
  }

  onChangePopUp(bool changePopUp) {
    emit(state.copyWith(changePopUp: changePopUp));
  }

//user for attributes dropdown
  void onChangeValueDropdownAttribute({
    required String idOption,
    required int index,
    required ValueOptionProduct selectedValue,
  }) {
    List<bool> isValid = List.from(state.isValid);
    isValid[index] = true;
    List<Option?> updatedCategories = state.options.map((c) {
      if (c?.id == idOption) {
        List<ValueOptionProduct> updatedValues = c!.values!.map((v) {
          if (v.id == selectedValue.id) {
            return v.copyWith(isSelected: true);
          } else {
            return v.copyWith(isSelected: false);
          }
        }).toList();

        return c.copyWith(values: updatedValues);
      }
      return c;
    }).toList();
    emit(state.copyWith(
      isValid: isValid,
      options: updatedCategories,
    ));
    // for check isvalid
    onValidPopSelected();
  }

// use for attributes filtering
  void onFieldAttributeValue({
    required String idOption,
    required String value,
    required int index,
  }) {
    List<bool> isValid = List.from(state.isValid);
    isValid[index] = true;
    List<Option?> updatedCategories = state.options.map((c) {
      if (c?.id == idOption) {
        List<ValueOptionProduct> updatedValues = c!.values!.map((v) {
          return v.copyWith(note: value, isSelected: true);
        }).toList();
        return c.copyWith(values: updatedValues);
      }
      return c;
    }).toList();

    emit(state.copyWith(
        isValid: isValid,
        options: updatedCategories,
        isSelected: !state.isSelected));
    // for check isvalid
    onValidPopSelected();
  }

// use for attributes selection
  void onSelectAttributeValue({
    required String idOption,
    required ValueOptionProduct selectedValue,
    required int index,
  }) {
    List<bool> isValid = List.from(state.isValid);
    isValid[index] = true;
    List<Option?> updatedCategories = state.options.map((c) {
      if (c?.id == idOption) {
        List<ValueOptionProduct> updatedValues = c!.values!.map((v) {
          if (v.id == selectedValue.id) {
            return v.copyWith(isSelected: true);
          } else {
            return v.copyWith(isSelected: false);
          }
        }).toList();

        return c.copyWith(values: updatedValues);
      }
      return c;
    }).toList();
    emit(state.copyWith(
        isValid: isValid,
        options: updatedCategories,
        isSelected: !state.isSelected));
    // for check isvalid
    onValidPopSelected();
  }
}
