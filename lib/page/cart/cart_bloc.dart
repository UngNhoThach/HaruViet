import 'dart:async';
import 'dart:math';

import 'package:haruviet/api/services/cart_orders/models/check_order_price_request/attribute_check_price.dart';
import 'package:haruviet/api/services/cart_orders/models/check_order_price_request/cart_check_price.dart';
import 'package:haruviet/api/services/cart_orders/models/check_order_price_request/check_order_price_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/check_order_price_response/check_order_price_response.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/data/reponsitory/product/models/price.dart';
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

    productsList = (await CartDatabaseV2().readAllItems());
    // List<CartCheckPrice> cartCheckPricex = [
    //   CartCheckPrice(
    //       productId: "172624274120",
    //       qty: 200,
    //       attribute: AttributeCheckPrice(
    //           options: ["9d0f7774-709d-40b8-8fb8-86f4581fd9d5"])),
    //   CartCheckPrice(productId: "172624274115", qty: 2, attribute: null),
    //   CartCheckPrice(
    //       productId: "172624274138",
    //       qty: 3,
    //       attribute: AttributeCheckPrice(options: [
    //         "9cffe0a8-1f1d-41c2-9346-75f84a6919f6",
    //         "9cffff50-b565-4cba-9866-c679f770493b"
    //       ])),
    //   CartCheckPrice(productId: "172624274116", qty: 20, attribute: null),
    //   CartCheckPrice(productId: "172624274139", qty: 2, attribute: null),
    // ];

// check price, gift product
    if (productsList.isEmpty) {
      cart.resetTotalPrice();
    } else {
      final List<CartCheckPrice> cartCheckPrice = [];

      // use for check first time get listAttributeCheckPrice
      List<AttributeCheckPrice?> listAttributeCheckPrice =
          List.from(state.attributeCheckPrice);
      for (var i = 0; i < productsList.length; i++) {
        // define attribute price for check
        AttributeCheckPrice? attributeCheckPrice;
        attributeCheckPrice ??= AttributeCheckPrice(options: []);
        // check if element have options empty or null
        if (listAttributeCheckPrice.length != productsList.length) {
          if (productsList[i].options == null ||
              productsList[i].options!.isEmpty) {
            // add the attribute into list attribute if options is empty
            listAttributeCheckPrice.add(null);
          } else {
            for (var option in productsList[i].options!) {
              // check if values of option are empty or null
              if (option!.values == null || option.values!.isEmpty) {
              } else {
                for (var value in option.values!) {
                  if (value.isSelected == true) {
                    attributeCheckPrice.options?.add(value.id);
                    print('${(value.id)}');
                  }
                }
              }
            }
            // add the attribute into list attribute if isselected is true
            listAttributeCheckPrice.add(attributeCheckPrice);
          }
        } else {}
        print(listAttributeCheckPrice);
        // after handle options and values, and it into cartCheckPrice
        cartCheckPrice.add(CartCheckPrice(
            productId: productsList[i].id,
            qty: productsList[i].totalQuantity,
            attribute: listAttributeCheckPrice[i]));
      }
      emit(
        state.copyWith(attributeCheckPrice: listAttributeCheckPrice),
      );
      List<DataProductDetailResponse> listGiftProduct = [];

      final checkOrderPriceResponse =
          await _cartOrderRepository.checkOrderPriceRP(
              request: CheckOrderPriceRequest(
                  customerType: "",
                  customerUsageCount: "",
                  inputCoupon: "",
                  paymentMethod: "",
                  cart: cartCheckPrice));
      var discountOrder = 0;

      var totalItem = 0;
      var discountDetail = 0;
      var isFreeShipping = false;
      double totalPriceItem = 0.0;

      // check is free shipping (done)
      isFreeShipping = checkOrderPriceResponse
              .firstWhere((element) => element.freeShipping == false,
                  orElse: () => CheckOrderPriceResponse(freeShipping: true))
              .freeShipping ==
          true;

      if (productsList != []) {
        List<Map<String, Price>> dataListUpdate = [];

        for (var element in checkOrderPriceResponse) {
          discountOrder += element.discountOrder ?? 0;
          discountDetail += element.discountDetail ?? 0;
          totalItem += element.qty!;
          totalPriceItem += element.totalPrice!.toDouble();
          if (element.gift != null) {
            final itemGift =
                await onGetGift(idProduct: element.gift?.giftId ?? '');
            listGiftProduct.add(itemGift);
            //    listGiftProduct[id]
          }
          dataListUpdate.add({
            element.productId ?? "": Price(
                price: splitCurrency(
                  element.price.toString(),
                ),
                discountDetail: element.discountDetail,
                discountOrder: element.discountOrder,
                totalPriceItem: element.totalPrice)
          });
        }

        cart.resetTotalPrice();
        productsList = await CartDatabaseV2()
            .updateProductsDescription(product: dataListUpdate);
        cart.addTotalPrice(totalPriceItem);
        cart.removeTotalPrice((discountOrder.toDouble() + discountDetail));
      }

      emit(
        state.copyWith(
            weight: totalItem,
            listGiftProduct: listGiftProduct,
            discountOrder: discountOrder + discountDetail,
            productsList: productsList,
            isFreeShipping: isFreeShipping,
            checkOrderPriceResponse: checkOrderPriceResponse,
            totalItem: cart.getCounter(),
            userInfoLogin: userInfoLogin),
      );
    }
    getDefaultPrice();

    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }

  Future<DataProductDetailResponse> onGetGift(
      {required String idProduct}) async {
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
        finalPriceDefault: cart.getTotalPrice().toInt() // sum,
        ,
        isValueDefault: true));
  }

  // change final value default of cart
  //onChangeFinalPrice() {
  // final cart = Provider.of<CartProviderV2>(context, listen: false);
  //  var productsList = List<CartModelProduct>.from(state.productsList);
  // int sum;
  // int sumValue;
  // int total;
  // sum = state.finalPriceDefault!;
  // sumValue = productsList.fold<int>(
  //     0, (previousValue, element) => previousValue + element.price.price!);
  // total = sumValue + sum;
  //   emit(state.copyWith(finalPrice: cart.getTotalPrice().toInt() // total,
  //       ));
  // }

  // update cart

  Timer? _debounce;
  fetchData() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    } else {
      _debounce = Timer(const Duration(milliseconds: 1800), () {
        getData();
      });
    }
  }

  onChangeValueDirec({
    required int index,
    required int value,
  }) {
    final cart = Provider.of<CartProviderV2>(context, listen: false);
    var productsList = List<CartModelProduct>.from(state.productsList);
    productsList = productsList.mapIndexed((i, element) {
      double totalPriceItem = 0.0;
      if (index == i) {
        final valueDefault = element.totalQuantity;
        if (value == valueDefault) {
          return element;
        } else if (value < valueDefault) {
          if (valueDefault >= 1 && value >= 1) {
            totalPriceItem = (valueDefault - value) *
                double.parse(element.price.price.toString());
            cart.removeTotalPrice((totalPriceItem));
          }
        } else {
          if (valueDefault >= 1 && value >= 1) {
            totalPriceItem = (value - valueDefault) *
                double.parse(element.price.price.toString());
            cart.addTotalPrice((totalPriceItem));
          }
        }
        getDefaultPrice();
        return element.copy(
          totalQuantity: value,
        );
      }
      return element;
    }).toList();
    emit(state.copyWith(
      productsList: productsList,
      // checkValue: !state.checkValue,
    ));
    onUpdate(index, productsList);
    // Debounce logic
    fetchData();
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
    fetchData();
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
    fetchData();
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
