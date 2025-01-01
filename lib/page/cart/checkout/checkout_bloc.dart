import 'package:flutter/material.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/create_order_request.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/data_order.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/data_total.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/item_detail.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/address/address_repository.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/get_cart_order_response/get_cart_order_response.dart';
import 'package:haruviet/data/reponsitory/payment/payment_data.dart';
import 'package:haruviet/data/reponsitory/shipment/shipping_repository.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/cart/checkout/widgets/checkout_params.dart';
import 'package:provider/provider.dart';

import 'checkout_state.dart';

class CheckOutBloc extends BaseBloc<CheckOutState> {
  final BuildContext context;

  CheckOutBloc(this.context) : super(const CheckOutState());

  // cart order repository
  final CartOrderRepository _cartOrderRepository = CartOrderRepository();

  // shipping repository
  final ShippingRepository _shippingRepository = ShippingRepository();

  // address repository
  final AddressRepository _addressRepository = AddressRepository();

  // final ShipmentRepository _shipmentRepository = ShipmentRepository();

// totalPrice: totalPrice
  getData(CheckoutParams params) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    // start get all products from the local store
    List<CartModelProduct> productsListRecommendations;
    productsListRecommendations = await CartProviderV2().getData();

    // end get all products from the local store

    final cart = Provider.of<CartProviderV2>(context, listen: false);
    List<GetCartOrderResponse> productsList = [];
    final userInfoLogin = await Preference.getUserInfo();
    final addressShipping = await Preference.getAddressShipping();
    final paymentData = await Preference.getPayment();
    final dataListAddress = await _addressRepository.getListAddressRP();

    // productsList = (await CartDatabaseV2().readAllItems());
    productsList = await _cartOrderRepository.getCartOrderRP();

    int totalPrice = cart.getTotalPrice().toInt();

    // lấy ra địa chỉ mặc định
    final addressShippingDefault = dataListAddress.data?.firstWhere(
      (element) => element.id == userInfoLogin?.addressId,
      orElse: () => DataListAddress(),
    );

    // fee shipping method

    List<String> shippingAddress = List.from(state.shippingAddress);
    if (addressShipping != null) {
      for (var i = 0; i < 4; i++) {
        switch (i) {
          case 0:
            shippingAddress.add(addressShipping.province ?? '');
            break;
          case 1:
            shippingAddress
                .add(splitStringWithComma(addressShipping.district ?? '')[1]);
            break;
          case 2:
            shippingAddress
                .add(splitStringWithComma(addressShipping.ward ?? '')[0]);
            break;
          case 3:
            shippingAddress.add(addressShipping.house ?? '');
            break;
          default:
        }
      }
    } else {
      for (var i = 0; i < 4; i++) {
        switch (i) {
          case 0:
            shippingAddress.add(addressShippingDefault?.province ?? '');
            break;
          case 1:
            shippingAddress.add(splitStringWithComma(
                addressShippingDefault?.district ?? '')[1]);
            break;
          case 2:
            shippingAddress.add(
                splitStringWithComma(addressShippingDefault?.ward ?? '')[0]);
            break;
          case 3:
            shippingAddress.add(addressShippingDefault?.house ?? '');
            break;
          default:
        }
      }
    }

    // final shipmentResponse = await _shipmentRepository.shipmentFeeRP(
    //     request: ShipmentRequest(
    //   address: shippingAddress[3],
    //   deliverOption: "none", // xteam or none
    //   ward: shippingAddress[2],
    //   district: shippingAddress[1],
    //   pickDistrict: "Quận 1",
    //   pickProvince: "Hồ Chí Minh",
    //   province: shippingAddress[0],
    //   tags: [
    //     1,
    //   ],
    //   transport: "road", //  or road or fly => fee
    //   value: totalPrice,
    //   weight: params.weight.toInt(),
    // ));
    // if (shipmentResponse.success == true) {
    //   emit(state.copyWith(
    //     shipmentResponse: shipmentResponse,
    //     // shippingFee: shipmentResponse.fee,
    //   ));
    // }

    // end fee shipping method

    emit(state.copyWith(
      userInfoLogin: userInfoLogin,
      discoutTotal: params.discountOrder,
      titleSelected: 'Giao hàng tiêu chuẩn (đường bộ)',
      selectedShipment:
          state.selectedShipment != 0 ? state.selectedShipment : 0,
      shippingAddress: shippingAddress,
      productsList: productsList,
      totalPrice: totalPrice,
      listAddresses: dataListAddress.data,
      idAddressShipping: addressShipping != null
          ? addressShipping.id
          : addressShippingDefault?.id,
      indexShippingMethod:
          paymentData != null ? paymentData.indexShippingMethod : 0,
      addressShipping: addressShipping ?? addressShippingDefault,
      valueShippingMethod: paymentData != null
          ? paymentData.paymentMethod ?? state.valueShippingMethod
          : 'Thanh toán khi nhận hàng (COD)',
    ));
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  // start get shipping methods
  onGetShippingMethods() async {
    emit(state.copyWith(isLoading: true));
    final shippingResponse = await _shippingRepository.shippingMethods();
    emit(state.copyWith(isLoading: false, shippingResponse: shippingResponse));
  }
  // end get shipping methods

  // start get payment methods
  onGetPaymentMethods() async {
    emit(state.copyWith(isLoading: true));
    final paymentResponse = await _shippingRepository.paymentMethods();
    emit(state.copyWith(
      paymentResponse: paymentResponse,
      isLoading: false,
    ));
  }
  // end get payment methods

  // start get items detail to create a new order
  onGetItemsDetail({required List<ItemDetail> itemsDetail}) {
    emit(state.copyWith(itemDetail: itemsDetail));
  }
  // end get items detail to create a new order

  // start get dataTotal to create a new order
  onGetDataTotal({required List<DataTotal> dataTotal}) {
    emit(state.copyWith(dataTotal: dataTotal));
  }
  // end get dataTotal to create a new order

  // start get dataOrder to create a new order
  onGetDataOrder({required DataOrder dataOrder}) {
    emit(state.copyWith(dataOrder: dataOrder));
  }
  // end get dataOrder to create a new order

  // start comment orders
  onChangeComment({required String comment}) {
    emit(state.copyWith(comment: comment));
  }
  // end comment orders

  // start create order
  onCreateOrder() {
    // user information on create order
    final userInfoLogin = state.userInfoLogin;
    final addressShipping = state.addressShipping;
    emit(state.copyWith(isLoading: true));

    if (state.isLoadingCreateOrders) {
      _cartOrderRepository.createOrdersRP(
          request: CreateOrderRequest(
              dataOrder: DataOrder(
                subtotal: state.totalPrice,
                shipping: state.shippingResponse?.shippingStandard?.value ?? 0,
                discount: state.discoutTotal,
                tax: 10,
                received: 0, // unknown
                paymentStatus: 1,
                shippingStatus: 1,
                status: 1, // trạng thái đơn hàng
                currency: "VND",
                exchangeRate: 1, // unknown
                total: (state.totalPrice ?? 0 + state.discoutTotal),
                balance: 0, // unknown
                paymentMethod: "cash",
                shippingMethod: "ShippingStandard",
                email: userInfoLogin?.email ?? '',
                firstName: userInfoLogin?.firstName ?? '',
                lastName: userInfoLogin?.lastName ?? '',
                comment: state.comment,
                company: userInfoLogin?.company ?? '',
                firstNameKana: userInfoLogin?.firstNameKana ?? '',
                lastNameKana: userInfoLogin?.lastNameKana ?? '',
                house: addressShipping?.house ?? '',
                street: addressShipping?.street ?? '',
                country: addressShipping?.country ?? 'VN',
                district: addressShipping?.district ?? '',
                idDistrict: addressShipping?.idDistrict ?? 0,
                idProvince: addressShipping?.idProvince ?? 0,
                idWard: addressShipping?.idWard ?? 0,
                phone: userInfoLogin?.phone ?? '',
                postcode: userInfoLogin?.postcode ?? '',
                province: addressShipping?.province ?? '',
                ward: addressShipping?.ward ?? '',
              ),
              dataTotal: [DataTotal()],

              // list items details to create order follow
              // databaseLocal =>  option => valueOptionproduct => isSelected == true
              itemDetail: [ItemDetail(), ItemDetail()]));
    } else {}

    emit(state.copyWith(isLoading: false));
  }
  // end create order

  // start get data from local storage

  // end get data from local storage

  onChangeSelectedShipment({required int selectedShipment}) {
    emit(state.copyWith(selectedShipment: selectedShipment));
  }

  // onChangeShipmentMethod(
  //     {required ShipmentResponse shipmentResponse,
  //     required String titleSelected}) {
  //   emit(state.copyWith(
  //       shipmentResponse: shipmentResponse, titleSelected: titleSelected));
  // }

  onChangeAddressShipping({required DataListAddress addressShipping}) {
    emit(state.copyWith(
        addressShipping: addressShipping,
        idAddressShipping: addressShipping.id));
  }

  onChangeValueShippingMethod(
      {required String valueShippingMethod, required int indexShippingMethod}) {
    emit(state.copyWith(
      indexShippingMethod: indexShippingMethod,
      valueShippingMethod: valueShippingMethod,
    ));
    onUpdatePaymentMethod(
        paymentData: PaymentData(
            paymentMethod: valueShippingMethod,
            indexShippingMethod: indexShippingMethod));
  }

// indexShippingMethod
  onUpdatePaymentMethod({
    required PaymentData paymentData,
  }) async {
    await Preference.setPayment(
      paymentData,
    );
  }
}
