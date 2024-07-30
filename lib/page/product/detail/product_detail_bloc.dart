import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/models/list_product/data_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/list_product/data_product/data_product.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/database_local/product/models/cart_model.dart';
import 'package:haruviet/database_local/product/cart_database.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/product/detail/product_detail_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ProductDetailBloc
class ProductDetailBloc extends BaseBloc<ProductDetailState> {
  final BuildContext context;
  ProductDetailBloc(this.context) : super(const ProductDetailState());
  final ProductRepository _productRepository = ProductRepository();
  List<Products> productsList = [];
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
      int totalItemInCart = await CartDatabase.instance.getCount();
      productsList = (await CartDatabase.instance.readAllItems());
      final checkAttributes = (productDetail.attributes == null) ||
              (productDetail.attributes!.isEmpty)
          ? false
          : true;

      emit(state.copyWith(
        userInfoLogin: userInfoLogin,
        dataProduct: productDetail,
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
    emit(state.copyWith(
      isLoading: false,
    ));
    onFetch(page: startPage);
  }

  onReset() {
    onFetch(page: startPage);
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
          size: state.limit.toString(), totalproduct: page.toString());

      final datatList = List<DataProduct>.from(state.datatList)
        ..addAll(productList.data ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      final canLoadMore = page <= maxLoadMore;

      emit(state.copyWith(
        datatList: datatList,
        newDataList: productList.data,
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
    final index =
        productList.indexWhere((element) => element.idProduct == idProduct);
    return index;
  }

  onAddItemToCart({
    required String idProduct,
    required String nameProduct,
    required String brandProduct,
    required String imageProduct,
    required String priceProduct,
    required String description,
    required int quantity,
  }) async {
    var productList = state.productsList;
    final index = checkIndexProducts(idProduct);
    final cart = Provider.of<CartProvider>(context, listen: false);

    if (index == -1) {
      final product = Products(
          nameProduct: nameProduct,
          description: description,
          isCompleted: false,
          totalQuantity: ValueNotifier<int>(quantity),
          idProduct: idProduct,
          brandProduct: brandProduct,
          imageProduct: imageProduct,
          priceProduct: priceProduct);
      await CartDatabase.instance.createCart(product);
      // onAddProductToCart();
      productList.add(product);
      cart.addCounter();
      cart.addTotalPrice(splitCurrency(product.priceProduct).toDouble());
      //  cart.addListener(() { })
    } else {
      // sản phẩm đã tồn tại trong giỏ hàng
      // productList[index].totalQuantity.value += quantity;
      // final updatedProduct = productList[index].copy(
      //     totalQuantity:
      //         ValueNotifier<int>(productList[index].totalQuantity.value));
      // await CartDatabase.instance.updateCart(updatedProduct);
      // cart.addTotalPrice(splitCurrency(updatedProduct.priceProduct).toDouble());
      emit(state.copyWith(checkProductInCart: true));
    }
    emit(state.copyWith(productsList: productList));
    emit(state.copyWith(checkProductInCart: false));
  }

  onSelectSize(String sizeSelected) async {
    if (!isClosed) {
      emit(state.copyWith(
        sizeSelected: sizeSelected,
      ));
      await onValidPopSelected();
    }
  }

  onSelectColor(String colorSelected) async {
    if (!isClosed) {
      emit(state.copyWith(
        colorSelected: colorSelected,
      ));
      await onValidPopSelected();
    }
  }

  onResetSelectAttributes(String colorSelected) {
    emit(state.copyWith(colorSelected: null, sizeSelected: null));
  }

  onHandleCounterChanged(int newCounter) async {
    if (!isClosed) {
      emit(state.copyWith(currentCounter: newCounter));
      await onValidPopSelected();
    }
  }

  onValidPopSelected() {
    bool check = state.sizeSelected != null &&
        state.colorSelected != null &&
        state.currentCounter != null;
    emit(state.copyWith(validBuyProductAttributes: check));
  }

  void onResetValiPopSelected() {
    if (!isClosed) {
      emit(state.copyWith(validBuyProductAttributes: false));
    }
  }

  onChangePopUp(bool changePopUp) {
    emit(state.copyWith(changePopUp: changePopUp));
  }
}
