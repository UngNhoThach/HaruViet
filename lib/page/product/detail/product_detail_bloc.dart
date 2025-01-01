import 'package:haruviet/api/services/cart_orders/models/add_products_request/add_products_request.dart';
import 'package:haruviet/api/services/cart_orders/models/add_products_request/options_add_products_request.dart';
import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/product/cart_database_v2.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:haruviet/database_local/products_recommendation/products_recommendation_database.dart';
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
  final CartOrderRepository _cartOrderRepository = CartOrderRepository();

  List<CartModelProduct> productsList = [];
  ValueNotifier<int> counter = ValueNotifier<int>(1);

  int splitCurrency(String currency) {
    List<String> parts = currency.split('.');
    int wholePart = int.parse(parts[0]);
    return wholePart;
  }

  onGetDataFromCategorys({
    required int page,
  }) async {
    try {
      List<DataProduct> updatedDataList = [];

      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMore: false,
            datatList: updatedDataList,
          ),
        );
      } else {
        updatedDataList = List<DataProduct>.from(state.datatList);
      }
      final productList = await _productRepository.getListProductsRP(
        request: GetListProductRequest(
          paegNumber: page,
          pageSize: state.limit,
          category: state.idCategory,
        ),
      );

      updatedDataList.addAll(productList.parseDataProduct() ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      final canLoadMore = page <= maxLoadMore;
      emit(state.copyWith(
        datatList: updatedDataList,
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

  getData(
    final String idProduct,
    final String domain,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final userInfoLogin = await Preference.getUserInfo();
      final productDetail =
          await _productRepository.getProductDetailsRP(idProduct: idProduct);

      // Xử lý specifications
      Map<String, dynamic> technical = {};
      if (productDetail.attributes != null &&
          productDetail.attributes!.isNotEmpty &&
          productDetail.attributes?[0]?.item != null &&
          productDetail.attributes![0]!.item!.isNotEmpty) {
        for (var element in productDetail.attributes![0]!.item!) {
          technical[element.title!] = element.values?[0].value ?? '';
        }
      }

      // Xử lý images
      final imageUrls = ['$domain${productDetail.image}'];
      if (productDetail.images != null && productDetail.images!.isNotEmpty) {
        imageUrls.addAll(productDetail.images!
            .map((e) => '$domain${e.image ?? ''}')
            .toList());
      }

      int totalItemInCart = CartProviderV2().getCounter();
      productsList = await CartDatabaseV2().readAllItems();

      final bool checkAttributes =
          productDetail.options != null && productDetail.options!.isNotEmpty;
      final List<bool> isValid = checkAttributes
          ? List.generate(productDetail.options!.length, (index) => false)
          : [];

      onValidPopSelected();

      emit(state.copyWith(
        technical: technical,
        htmlData: productDetail.descriptions?.content ?? '',
        // dataDetail: {
        //   '': convertHTMLToString(productDetail.descriptions?.content ?? '')
        // },
        dataProduct: productDetail,
        isValid: isValid,
        idCategory: productDetail.categories?[0].id,
        nameCategory: productDetail.categories?[0].title,
        isLoginsSuccess: userInfoLogin?.isLogin ?? false,
        productStoreDefault: productDetail.stock,
        attributes: productDetail.attributes,
        options: productDetail.options,
        totalProductInCart: totalItemInCart,
        productsList: productsList,
        imageUrls: imageUrls,
        checkProductAttributes: checkAttributes,
        isLoading: false,
      ));
      await Future.wait([
        onGetProductRecommendations(),
        onGetDataFromCategorys(page: startPage),
        onFetchProductFromBrand(page: startPage),
        onFetch(page: startPage)
      ].whereType<Future>());
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("$error + $stackTrace");
      }
      emit(state.copyWith(
        viewState: ViewState.error,
        errorMsg: error.toString(),
      ));
    }
  }

  // get product recommendations from local database
  onGetProductRecommendations() async {
    List<DataProduct> productsListRecommendations = [];
    productsListRecommendations =
        await ProductRecommendationDatabase().getAllProducts(limit: 12);
    emit(state.copyWith(
        productsListRecommendations: productsListRecommendations));
  }

// get product flow brand
  onFetchProductFromBrand({
    required int page,
  }) async {
    emit(state.copyWith(isLoadingProductBrand: true));

    try {
      List<DataProduct> updatedDatatListBrand = [];

      if (page == startPage) {
        emit(
          state.copyWith(
            newDataListBrand: null,
            canLoadMore: false,
            datatListBrand: updatedDatatListBrand,
          ),
        );
      } else {
        updatedDatatListBrand = List<DataProduct>.from(state.datatListBrand);
      }
      final productList = await _productRepository.getListProductsRP(
        request: GetListProductRequest(
          paegNumber: page,
          pageSize: state.limit,
          // category: state.idCategory,
        ),
      );
      updatedDatatListBrand.addAll(productList.parseDataProduct() ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      final canLoadMore = page <= maxLoadMore;
      emit(state.copyWith(
          datatListBrand: updatedDatatListBrand,
          newDataListBrand: productList.parseDataProduct(),
          currentPage: page,
          canLoadMore: canLoadMore,
          isLoadingProductBrand: false));

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

  //  this.isLoadingProductRecommendation = false,
  //   this.isLoadingProductBrand = false,
  //   this.isLoadingProductCategory = false,
  // product list
  bool canLoadMoreRecommendationProduct = false;
  onFetch({
    required int page,
  }) async {
    try {
      // emit(state.copyWith(isLoadingProductRecommendation: true));

      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMoreRecommendationProduct: false,
          ),
        );
      }
      final productList = await _productRepository.getListProductsRP(
        request: GetListProductRequest(paegNumber: page, pageSize: state.limit),
      );

      final datatList = List<DataProduct>.from(state.datatList)
        ..addAll(productList.parseDataProduct() ?? []);

      final loadingCount = ((productList.total ?? 0) / state.limit);
      final maxLoadMore = loadingCount.floor();
      if (isINT(loadingCount)) {
        canLoadMoreRecommendationProduct = page < maxLoadMore;
      } else {
        canLoadMoreRecommendationProduct = page <= maxLoadMore;
        print('error');
      }

      emit(state.copyWith(
        datatList: datatList,
        newDataList: productList.parseDataProduct(),
        currentPage: page,
        canLoadMoreRecommendationProduct: canLoadMoreRecommendationProduct,
        //    isLoadingProductRecommendation: false,
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

  // start check id product is available
  int checkIndexProducts(String idProduct) {
    final productList = state.productsList;
    final index = productList.indexWhere((element) => element.id == idProduct);
    return index;
  }
  // end check id product is available

  bool isINT(double number) {
    return number % 1 == 0;
  }

// start add product to cart locally
  onAddItemToCart(
      {required ProductParams productParams,
      required int quantity,
      required String productId}) async {
    onGetOptionIsSelected();
    final cart = Provider.of<CartProviderV2>(context, listen: false);

    final index = checkIndexProducts(productParams.dataProduct.id ?? '');
    // change quality
    productParams.dataProduct.totalQuantity = state.currentCounter;
    productParams.dataProduct.options = state.options;
    if (index == -1) {
      cart.addCounter(setCounter: 0);

      addProductToCart(
          cart: cart,
          quantity: quantity,
          productId: productId,
          productParams: productParams);
    } else {
      // sản phẩm đã tồn tại trong giỏ hàng
      emit(state.copyWith(checkProductInCart: true));
    }
    emit(state.copyWith(checkProductInCart: false));
  }
  // end add product to cart locally

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

  // void onGetOptionIsSelected() {
  //   List<Option> listOption =
  //       List<Option>.from(state.dataProduct?.options ?? []);
  //   Map<String, dynamic> options = {};
  //   for (var item in listOption) {
  //     // add for field option
  //     if (item.type == "field") {
  //       for (var value in item.values!) {
  //         if (value.isSelected == true) {
  //           options[item.id ?? ''] = value.title ?? '';
  //           break;
  //         }
  //       }
  //       // add for selected option
  //     } else {
  //       for (var value in item.values!) {
  //         if (value.isSelected == true) {
  //           options[item.id ?? ''] = [value.id ?? ''];
  //           break;
  //         }
  //       }
  //     }
  //   }
  // }

  void onGetOptionIsSelected() {
    List<Option?> listOption = state.options;
    Map<String, dynamic> options = {};

    for (var item in listOption) {
      var selectedValue = item?.values?.firstWhere(
        (value) => value.isSelected == true,
        orElse: () => ValueOptionProduct(),
      );

      if (selectedValue != null) {
        options[item?.id ?? ''] = item?.type == "field"
            ? selectedValue.note ?? ''
            : [selectedValue.id ?? ''];
      }
    }
    print(options);
    emit(state.copyWith(optionsSelected: options));
  }

  // start add product to cart
  addProductToCart(
      {required int quantity,
      required String productId,
      required ProductParams productParams,
      required CartProviderV2 cart}) async {
    var productList = state.productsList;
    // get list options
    final addItemmResponse = await _cartOrderRepository.addItemToCartRP(
        request: AddProductsRequest(
            productId: productId,
            qty: quantity,
            options: state.optionsSelected == null
                ? null
                : OptionsAddProductsRequest(options: [
                    state.optionsSelected!,
                  ])));

    if (addItemmResponse.success == null || !addItemmResponse.success!) {
      emit(state.copyWith(message: 'Lỗi thêm sản phẩm vui lòng thử lại sau'));
      cart.removeCounter();
    } else {
      // start convert data from format CartModelProduct to cartProduct
      final CartModelProduct cartProduct =
          CartModelProduct.fromDataProduct(productParams.dataProduct);
      // end convert data from format CartModelProduct to cartProduct

      await CartDatabaseV2().insertProductFromDataProduct(
        productParams.dataProduct,
      );
      productList.add(cartProduct);
      emit(state.copyWith(productsList: productList));
    }
    emit(state.copyWith(message: null));
  }
  // end add product to cart
}
