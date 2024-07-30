import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/models/product_response.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/database_local/product/models/cart_model.dart';
import 'package:haruviet/database_local/product/cart_database.dart';
import 'package:haruviet/page/cart/cart_sate.dart';
import 'package:haruviet/page/cart/models/cart_item_request.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBloc extends BaseBloc<CartState> {
  final BuildContext context;

  CartBloc(this.context) : super(const CartState());
  List<Products> productsList = [];

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final cart = Provider.of<CartProvider>(context, listen: false);
    final userInfoLogin = await Preference.getUserInfo();

    productsList = (await CartDatabase.instance.readAllItems());

    emit(
      state.copyWith(
          productsList: productsList,
          totalItem: cart.getCounter(),
          isLoading: false,
          userInfoLogin: userInfoLogin),
    );
    getDefaultPrice();
  }

  int splitCurrency(String currency) {
    List<String> parts = currency.split('.');
    int wholePart = int.parse(parts[0]);

    return wholePart;
  }

  onDeletaItems({
    required int index,
  }) async {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final product = state.productsList[index];
    final ValueNotifier<int> countTotalProductInItems = product.totalQuantity;
    double totalPriceItem = countTotalProductInItems.value *
        double.parse(splitCurrency(product.priceProduct).toString());
    cart.removeItem(product.idProduct);
    cart.removeTotalPrice((totalPriceItem));
    cart.removeCounter();
    await CartDatabase.instance.deleteCart(product.idProduct);
    emit(state.copyWith(
      totalItem: cart.getCounter(),
    ));
    getData();
  }

  onChangeValueDirec({
    required int index,
    required int value,
  }) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    var productsList = List<Products>.from(state.productsList);
    productsList = productsList.mapIndexed((i, element) {
      double totalPriceItem = 0.0;
      if (index == i) {
        final valueDefault = element.totalQuantity.value;
        if (value == valueDefault) {
          return element;
        } else if (value < valueDefault) {
          if (valueDefault >= 1 && value >= 1) {
            totalPriceItem = (valueDefault - value) *
                double.parse(splitCurrency(element.priceProduct).toString());
            cart.removeTotalPrice((totalPriceItem));
          }
        } else {
          if (valueDefault >= 1 && value >= 1) {
            totalPriceItem = (value - valueDefault) *
                double.parse(splitCurrency(element.priceProduct).toString());
            cart.addTotalPrice((totalPriceItem));
          }
        }
        getDefaultPrice();
        return element.copy(
          totalQuantity: ValueNotifier<int>(value),
        );
      }
      return element;
    }).toList();
    emit(state.copyWith(
      productsList: productsList,
      // checkValue: !state.checkValue,
    ));
    onUpdate(index, productsList);
    //  onChangeFinalPrice();
  }

  getDefaultPrice() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    emit(state.copyWith(
        finalPriceDefault: cart.getTotalPrice().toInt() // sum,
        ,
        isValueDefault: true));
  }

  // change final value default of cart
  onChangeFinalPrice() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    var productsList = List<Products>.from(state.productsList);
    int sum;
    int sumValue;
    int total;
    sum = state.finalPriceDefault!;
    sumValue = productsList.fold<int>(
        0,
        (previousValue, element) =>
            previousValue + (splitCurrency(element.priceProduct)));
    total = sumValue + sum;
    emit(state.copyWith(finalPrice: cart.getTotalPrice().toInt() // total,
        ));
  }

  onChangeDecrementCounter(int index) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    var productsList = List<Products>.from(state.productsList);
    productsList = productsList.mapIndexed((i, element) {
      if (index == i) {
        if (element.totalQuantity.value > 1) {
          int count = element.totalQuantity.value;
          count = count - 1;
          cart.removeTotalPrice(splitCurrency(element.priceProduct).toDouble());
          getDefaultPrice();

          return element.copy(
            totalQuantity: ValueNotifier<int>(count),
            //   totalPriceItem: (count - 1) * element.price!,
          );
        }
      }
      return element;
    }).toList();
    emit(state.copyWith(
      productsList: productsList,
      checkValue: !state.checkValue,
    ));
    onUpdate(index, productsList);

    // onChangeFinalPrice();
  }

  onChangeIncrementCounter(int index) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    var productsList = List<Products>.from(state.productsList);
    productsList = productsList.mapIndexed((i, element) {
      if (index == i) {
        int count = element.totalQuantity.value;
        count = count + 1;
        cart.addTotalPrice(splitCurrency(element.priceProduct).toDouble());
        getDefaultPrice();
        return element.copy(
          totalQuantity: ValueNotifier<int>(count),
        );
      }
      return element;
    }).toList();
    emit(state.copyWith(
      productsList: productsList,
      checkValue: !state.checkValue,
    ));
    onUpdate(index, productsList);
  }

  onUpdate(int index, productList) async {
    final updatedProduct = productList[index].copy(
        totalQuantity:
            ValueNotifier<int>(productList[index].totalQuantity.value));
    await CartDatabase.instance.updateCart(updatedProduct);
  }

//
  onDeleteItem({
    required int index,
    required String idProduct,
  }) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    var listCategories = List<ProductResponse>.from(state.listCategories);
    listCategories.removeAt(index);

    var listCategoriesCartItem =
        List<CartItemRequest>.from(state.cartItemsRequest);
    listCategoriesCartItem.removeAt(index);
    cart.removeCounter();
    cart.removeItem(idProduct);

    emit(state.copyWith(
        cartItemsRequest: listCategoriesCartItem,
        listCategories: listCategories,
        isValueDefault: false));
    getDefaultPrice();
    //  onChangeFinalPrice();
  }
}
