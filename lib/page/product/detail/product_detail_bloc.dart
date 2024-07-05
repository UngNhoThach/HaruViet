import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/product/product_repository.dart';
import 'package:eco_app/database_local/product/cart_provider.dart';
import 'package:eco_app/database_local/product/models/cart_model.dart';
import 'package:eco_app/database_local/product/cart_database.dart';
import 'package:eco_app/page/product/detail/product_detail_state.dart';
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
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final userInfoLogin = await Preference.getUserInfo();
      final productDetail =
          await _productRepository.getProductDetailsRP(idProduct: idProduct);

      final imageUrls = [
        '${productDetail.image}',
      ];

      int totalItemInCart = await CartDatabase.instance.getCount();
      productsList = (await CartDatabase.instance.readAllItems());

      emit(state.copyWith(
        userInfoLogin: userInfoLogin,
        dataProduct: productDetail,
        totalProductInCart: totalItemInCart,
        productsList: productsList,
        imageUrls: imageUrls,
        checkProductAttributes:
            productDetail.attributes!.isEmpty ? false : true,
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
  }

//   getDataAttributes() async {
//     emit(state.copyWith(
//       isLoading: true,
//     ));
//     try {
//       List<Color> convertJsonToColorList(List<Map<String, dynamic>> jsonData) {
//    state.dataProduct!.attributes!.map((e) => e).toList();

//   // .toList();
// }
//       List<Color> colors = convertJsonToColorList(apiData);
//       emit(state.copyWith(

//         productsList: productsList,
//       ));
//     } catch (error, statckTrace) {
//       if (kDebugMode) {
//         print("$error + $statckTrace");
//       }
//       emit(state.copyWith(
//           viewState: ViewState.error, errorMsg: error.toString()));
//     }
//     emit(state.copyWith(
//       isLoading: false,
//     ));
//   }

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
  }) async {
    var productList = state.productsList;
    final index = checkIndexProducts(idProduct);
    final cart = Provider.of<CartProvider>(context, listen: false);

    if (index == -1) {
      final product = Products(
          nameProduct: nameProduct,
          description: description,
          isCompleted: false,
          totalQuantity: ValueNotifier<int>(1),
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
      productList[index].totalQuantity.value += 1;
      final updatedProduct = productList[index].copy(
          totalQuantity:
              ValueNotifier<int>(productList[index].totalQuantity.value));
      await CartDatabase.instance.updateCart(updatedProduct);
      cart.addTotalPrice(splitCurrency(updatedProduct.priceProduct).toDouble());
      emit(state.copyWith(checkProductInCart: true));
    }
    emit(state.copyWith(productsList: productList));
    emit(state.copyWith(checkProductInCart: false));
  }

  onAddProductToCart() {
    int quantity = state.totalProductInCart! + 1;
    emit(state.copyWith(totalProductInCart: quantity));
  }

  onSelectSize(String sizeSelected) async {
    emit(state.copyWith(
      sizeSelected: sizeSelected,
    ));
    await onValidPopSelected();
  }

  onSelectColor(String colorSelected) async {
    emit(state.copyWith(
      colorSelected: colorSelected,
    ));
    await onValidPopSelected();
  }

  onResetSelectAttributes(String colorSelected) {
    emit(state.copyWith(colorSelected: null, sizeSelected: null));
  }

  onHandleCounterChanged(int newCounter) async {
    emit(state.copyWith(currentCounter: newCounter));
    await onValidPopSelected();
  }

  onValidPopSelected() {
    bool check = state.sizeSelected != null &&
        state.colorSelected != null &&
        state.currentCounter != 0;
    emit(state.copyWith(validBuyProductAttributes: check));
  }

  onResetValiPopSelected() {
    emit(state.copyWith(validBuyProductAttributes: false));
  }
}
