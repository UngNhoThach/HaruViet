import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/reponsitory/product/models/product_response.dart';
import 'package:eco_app/database_local/product/cart_provider.dart';
import 'package:eco_app/database_local/product/models/cart_model.dart';
import 'package:eco_app/database_local/product/cart_database.dart';
import 'package:eco_app/page/cart/cart_sate.dart';
import 'package:eco_app/page/cart/models/cart_item_request.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBloc extends BaseBloc<CartState> {
  final BuildContext context;

  CartBloc(this.context) : super(const CartState());
  List<Products> productsList = [];

  getData() async {
    final cart = Provider.of<CartProvider>(context, listen: false);

    emit(state.copyWith(
      isLoading: true,
    ));

    productsList = (await CartDatabase.instance.readAllItems());

    emit(
      state.copyWith(
        productsList: productsList,
        totalItem: cart.getCounter(),
        isLoading: false,
      ),
    );

    if (!state.isValueDefault) {
      getDefaultPrice();
    }
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

    await CartDatabase.instance.deleteCart(state.productsList[index].idProduct);
    cart.removeItem(state.productsList[index].idProduct);
    cart.removeCounter();

    getData();
  }

  // List<CartItemRequest> initializeCartItems(int totalItem) {
  //   List<CartItemRequest> cartItems = [];
  //   for (int i = 0; i < totalItem; i++) {
  //     cartItems.add(CartItemRequest(
  //       quality: 1,
  //       price: 900000,
  //     ));
  //   }
  //   return cartItems;
  // }

  onChangeValueDirec(
    int index,
    int? value,
  ) {
    var listItem = List<CartItemRequest>.from(state.cartItemsRequest);
    listItem = listItem.asMap().entries.map((entry) {
      var i = entry.key;
      var element = entry.value;
      if (index == i) {
        if (value != null && value > 1) {
          return element.copyWith(
              quality: value, totalPriceItem: (value - 1) * element.price!);
        }
      }
      return element;
    }).toList();

    emit(state.copyWith(
      cartItemsRequest: listItem,
    ));
    onChangeFinalPrice();
  }

  getDefaultPrice() {
    // var productsList = List<Products>.from(state.productsList);
    final cart = Provider.of<CartProvider>(context, listen: false);

    // int sum;
    // sum = productsList.fold<int>(
    //     0,
    //     (previousValue, element) =>
    //         previousValue + (splitCurrency(element.priceProduct)));

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

          // totalPriceItem: (count - 1) * element.price!,
        );
      }
      return element;
    }).toList();
    emit(state.copyWith(
      productsList: productsList,
      checkValue: !state.checkValue,
    ));
    onUpdate(index, productsList);
    //   getDefaultPrice();

    //  onChangeFinalPrice();
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
