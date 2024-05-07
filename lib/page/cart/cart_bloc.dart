import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/reponsitory/product/product_response.dart';
import 'package:eco_app/page/cart/cart_sate.dart';
import 'package:eco_app/page/cart/models/cart_item_request.dart';
import 'package:collection/collection.dart';

class CartBloc extends BaseBloc<CartState> {
  CartBloc() : super(const CartState());
  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    List<ProductResponse> listCategories() {
      return [
        ProductResponse(
            id: 1,
            code: '9032451',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 2,
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            code: '90324529032452',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 3,
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            code: '9032453',
            amount: '1',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 4,
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            code: '9032454',
            amount: '1',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 5,
            amount: '1',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            code: '9032455',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 6,
            code: '9032456',
            amount: '1',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 7,
            code: '90324579032452',
            price: '900000',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            name: 'Máy lạnh toshiba inverter 2 hp-End',
            isCheck: false),
        ProductResponse(
            id: 8,
            code: '9032458',
            price: '900000',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 9,
            code: '9032459',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 10,
            code: '90324510',
            amount: '1',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
        ProductResponse(
            id: 11,
            code: '903245119032452',
            image:
                'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
            amount: '1',
            price: '900000',
            name: 'Máy lạnh toshiba inverter 2 hp',
            isCheck: false),
      ];
    }

    final totalItem = listCategories().length;

    emit(
      state.copyWith(
        listCategories: listCategories(),
        totalItem: totalItem,
        cartItemsRequest: initializeCartItems(totalItem),
        isLoading: false,
      ),
    );

    if (!state.isValueDefault) {
      getDefaultPrice();
    }
  }

  List<CartItemRequest> initializeCartItems(int totalItem) {
    List<CartItemRequest> cartItems = [];
    for (int i = 0; i < totalItem; i++) {
      cartItems.add(CartItemRequest(
        quality: 1,
        price: 900000,
      ));
    }
    return cartItems;
  }

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

  onChangeDecrementCounter(int index) {
    var listItem = List<CartItemRequest>.from(state.cartItemsRequest);
    listItem = listItem.mapIndexed((i, element) {
      if (index == i) {
        if (element.quality != null && element.quality! > 1) {
          int count = element.quality!;
          count = count - 1;
          return element.copyWith(
            quality: count,
            totalPriceItem: (count - 1) * element.price!,
          );
        }
      }
      return element;
    }).toList();
    emit(state.copyWith(
      cartItemsRequest: listItem,
      checkValue: !state.checkValue,
    ));
    onChangeFinalPrice();
  }

  getDefaultPrice() {
    var listItem = List<CartItemRequest>.from(state.cartItemsRequest);
    int sum;
    sum = listItem.fold<int>(
        0, (previousValue, element) => previousValue + (element.price ?? 0));

    emit(state.copyWith(finalPriceDefault: sum, isValueDefault: true));
  }

  onChangeFinalPrice() {
    var listItem = List<CartItemRequest>.from(state.cartItemsRequest);
    int sum;
    int sumValue;
    int total;
    sum = state.finalPriceDefault!;

    sumValue = listItem.fold<int>(
        0,
        (previousValue, element) =>
            previousValue + (element.totalPriceItem ?? 0));
    total = sumValue + sum;
    emit(state.copyWith(
      finalPrice: total,
    ));
  }

  onChangeIncrementCounter(int index) {
    var listItem = List<CartItemRequest>.from(state.cartItemsRequest);
    listItem = listItem.mapIndexed((i, element) {
      if (index == i) {
        int count = element.quality != null ? element.quality! : 1;
        count = count + 1;
        return element.copyWith(
          quality: count,
          totalPriceItem: (count - 1) * element.price!,
        );
      }
      return element;
    }).toList();
    emit(state.copyWith(
      cartItemsRequest: listItem,
      checkValue: !state.checkValue,
    ));
    onChangeFinalPrice();
  }

  onDeleteItem({
    required int index,
  }) {
    var listCategories = List<ProductResponse>.from(state.listCategories);
    listCategories.removeAt(index);

    var listCategoriesCartItem =
        List<CartItemRequest>.from(state.cartItemsRequest);
    listCategoriesCartItem.removeAt(index);
    final total = state.totalItem;
    int temp;
    if (total != null) {
      temp = total - 1;
    } else {
      temp = 0;
    }
    emit(state.copyWith(
        totalItem: temp,
        cartItemsRequest: listCategoriesCartItem,
        listCategories: listCategories,
        isValueDefault: false));
    getDefaultPrice();

    onChangeFinalPrice();
  }
}
