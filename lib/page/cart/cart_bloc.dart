import 'dart:async';

import 'package:haruviet/api/services/cart_orders/models/check_order_price_request/attribute_check_price.dart';
import 'package:haruviet/api/services/cart_orders/models/remove_item_from_cart_request/remove_item_from_cart_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/get_cart_order_response/get_cart_order_response.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/product_response.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/product/cart_database_v2.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:haruviet/page/cart/cart_sate.dart';
import 'package:haruviet/page/cart/models/cart_item_request.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBloc extends BaseBloc<CartState> {
  final BuildContext context;

  CartBloc(this.context) : super(const CartState());
  final CartOrderRepository _cartOrderRepository = CartOrderRepository();
  final ProductRepository _productRepository = ProductRepository();

  List<CartModelProduct> productsList = [];

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    // checkOrderPriceRP
    final cart = Provider.of<CartProviderV2>(context, listen: false);
    final userInfoLogin = await Preference.getUserInfo();
//    cart.removeItem("172872031769");
    //  productsList = (await CartDatabaseV2().readAllItems());

    // count tax and weight
    double weight = 0.0;
    var tax = 0;
    // start get user order from server
    List<DataProduct> listGiftProduct = [];

    final listItemsCartOrder = await _cartOrderRepository.getCartOrderRP();
    // end get user order from server
    int totalItem = 0;
    var discountOrder = 0;
    var discountDetail = 0;
    var isFreeShipping = false;
    double totalPriceItem = 0.0;

    // start check is free shipping
    isFreeShipping = listItemsCartOrder
            .firstWhere(
                (element) =>
                    element != null ? element.freeShipping == false : false,
                orElse: () => GetCartOrderResponse(
                      freeShipping: true,
                    ))
            .freeShipping ==
        true;
    // end check is free shipping

    // start renew data from server
    if (listItemsCartOrder != []) {
      // List<Map<String, Price>> dataListUpdate = [];
      for (var element in listItemsCartOrder) {
        // count tax
        tax += element.tax ?? 0;

        if (element.attributes == null) {
        } else {
          discountOrder += element.discount ?? 0;
          discountDetail += element.discount ?? 0;
          if (element.gift == null) {
          } else {
            // add gift

            final itemGift =
                await onGetGift(idProduct: element.gift?.giftId ?? '');
            listGiftProduct.add(itemGift);
          }
        }
        // count total quantity items
        totalItem += element.qty!;
        // count total price items
        totalPriceItem += element.total!.toDouble();

        /// update data product to local

        // dataListUpdate.add({
        //   element.productId ?? "": Price(
        //       price: splitCurrency(
        //         element.price.toString(),
        //       ),
        //       totalQuantity: element.qty,
        //       discountDetail: element.discountDetail,
        //       discountOrder: element.discountOrder,
        //       totalPriceItem: element.totalPrice)
        // });
      }

      cart.resetTotalPrice();
      // productsList = await CartDatabaseV2()
      //     .updateProductsDescription(product: dataListUpdate);
      cart.addTotalPrice(totalPriceItem);
      cart.removeTotalPrice((discountOrder.toDouble() + discountDetail));
    }
    // end renew data from server

    emit(
      state.copyWith(
          // get cart order
          listItemsCartOrder: listItemsCartOrder,
          weight: weight,
          listGiftProduct: listGiftProduct,
          discountOrder: discountOrder + discountDetail,
          productsList: productsList,
          isFreeShipping: isFreeShipping,
          //  checkOrderPriceResponse: checkOrderPriceResponse,
          totalItem: listItemsCartOrder.length, //cart.getCounter(),
          userInfoLogin: userInfoLogin),
    );
    //   }
    getDefaultPrice();

    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }

  // on update item from cart order
  onUpdateItemFromCartOrder({
    required String rowId,
    required String id,
    required int newQty,
  }) async {
    emit(state.copyWith(
      isNextPage: false,
    ));
    final response = await _cartOrderRepository.updateCartOrderRP(
        request: RemoveItemFromCartRequest(
      id: id,
      newQty: newQty,
      rowId: rowId,
    ));
    if (response.success == null || !response.success!) {
      emit(state.copyWith(
        message: response.message,
        isUpdateDone: !state.isUpdateDone,
        isNextPage: true,
      ));

      print(response);
    } else {
      getData();
    }
    emit(state.copyWith(
      message: null,
    ));
  }

  // ondelete item from cart order
  onDeleteItemFromCartOrder(
      {required String rowId,
      required int index,
      required String idProduct}) async {
    // remove item from cart order
    final cart = Provider.of<CartProviderV2>(context, listen: false);
    cart.removeCounter();
    cart.removeItem(idProduct);
    onDeleteBefoGetData(index: index);

    final response = await _cartOrderRepository.removeItemFromCartRP(
        request: RemoveItemFromCartRequest(rowId: rowId));
    if (response.success == null || !response.success!) {
    } else {
      getData();
    }
  }

  onDeleteBefoGetData({
    required int index,
  }) {
    var listCategoriesCartItem =
        List<GetCartOrderResponse>.from(state.listItemsCartOrder);
    listCategoriesCartItem.removeAt(index);
    emit(state.copyWith(listItemsCartOrder: listCategoriesCartItem));
  }

  // count weight products
  double coutWeightToDouble(String weight, int quantity) {
    final temp = double.parse(weight);
    final value = quantity * temp;
    return value;
  }

  Future<DataProduct> onGetGift({required String idProduct}) async {
    return await _productRepository.getProductDetailsRP(idProduct: idProduct);
  }

  int splitCurrency(String currency) {
    List<String> parts = currency.split('.');
    int wholePart = int.parse(parts[0]);
    return wholePart;
  }

  onDeletaItems({
    required int index,
  }) async {
    final cart = Provider.of<CartProviderV2>(context, listen: false);
    final product = state.productsList[index];
    cart.removeItem(product.id);

    //   cart.removeTotalPrice((totalPriceItem));
    List<AttributeCheckPrice?> listAttributeCheckPrice =
        List.from(state.attributeCheckPrice);
    listAttributeCheckPrice.removeAt(index);
    cart.removeCounter();
    await CartDatabaseV2().deleteProduct(product.id);
    emit(state.copyWith(
      attributeCheckPrice: listAttributeCheckPrice,
      totalItem: cart.getCounter(),
    ));
    getData();
  }

  getDefaultPrice() {
    final cart = Provider.of<CartProviderV2>(context, listen: false);
    emit(state.copyWith(
        isNextPage: true,
        finalPriceDefault: cart.getTotalPrice().toInt(),
        isValueDefault: true));
    // start update total products in local store
    final tempTotalItems = cart.getCounter();

    if (state.totalItem != tempTotalItems && state.totalItem != null) {
      cart.addCounter(setCounter: state.totalItem ?? 0);
    }
    // end update total products in local store
  }

  // update cart

  onChangeValueDirec({
    required int index,
    required int value,
  }) {
    //   final cart = Provider.of<CartProviderV2>(context, listen: false);
    var productsList = List<CartModelProduct>.from(state.productsList);
    bool temp = false;

    productsList = productsList.mapIndexed((i, element) {
      //   double totalPriceItem = 0.0;
      if (value == element.totalQuantity) {
      } else {
        if (index == i) {
          temp = true;

          // final valueDefault = element.totalQuantity;
          // if (value == valueDefault) {
          //   return element;
          // } else if (value < valueDefault) {
          //   if (valueDefault >= 1 && value >= 1) {
          //     // totalPriceItem = (valueDefault - value) *
          //     //     double.parse(element.price.price.toString());
          //     //        cart.removeTotalPrice((totalPriceItem));
          //   }
          // } else {
          //   if (valueDefault >= 1 && value >= 1) {
          //     // totalPriceItem = (value - valueDefault) *
          //     //     double.parse(element.price.price.toString());
          //     //           cart.addTotalPrice((totalPriceItem));
          //   }
          // }
          //  getDefaultPrice();
          return element.copy(
            totalQuantity: value,
          );
        }
      }
      return element;
    }).toList();
    emit(state.copyWith(
      productsList: productsList,
    ));
    onUpdate(index, productsList);
    if (temp) {
      getData();
      emit(state.copyWith(
          // isReloadNewCart: !state.isReloadNewCart,
          ));
    }
  }

  onChangeDecrementCounter(int index) {
    final cart = Provider.of<CartProviderV2>(context, listen: false);
    var productsList = List<CartModelProduct>.from(state.productsList);
    productsList = productsList.mapIndexed((i, element) {
      if (index == i) {
        if (element.totalQuantity > 1) {
          int count = element.totalQuantity;
          count = count - 1;
          cart.removeTotalPrice(double.parse(element.price.price.toString()));
          getDefaultPrice();
          return element.copy(
            totalQuantity: count,
            totalPriceItem: (count - 1) * element.price.price!.toDouble(),
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

    // Debounce logic
  }

  onChangeIncrementCounter(int index) async {
    final cart = Provider.of<CartProviderV2>(context, listen: false);

    var productsList = List<CartModelProduct>.from(state.productsList);
    productsList = productsList.mapIndexed((i, element) {
      if (index == i) {
        int count = element.totalQuantity;
        count = count + 1;
        cart.addTotalPrice(double.parse(element.price.price.toString()));
        //   cart.addQuantity(element.id);
        getDefaultPrice();
        return element.copy(
          totalQuantity: count,
        );
      }
      return element;
    }).toList();
    emit(state.copyWith(
      productsList: productsList,
      checkValue: !state.checkValue,
    ));
    await onUpdate(index, productsList);

    // Debounce logic
  }

  onUpdate(int index, productList) async {
    final updatedProduct = productList[index]
        .copy(totalQuantity: productList[index].totalQuantity);
    await CartDatabaseV2().updateProduct(updatedProduct);
  }

  onDeleteItem({
    required int index,
    required String idProduct,
  }) {
    final cart = Provider.of<CartProviderV2>(context, listen: false);

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
