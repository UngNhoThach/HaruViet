import 'package:flutter/material.dart';
import 'package:haruviet/api/services/shipment/models/shipment_request/shipment_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/address/address_repository.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/reponsitory/payment/payment_data.dart';
import 'package:haruviet/data/reponsitory/shipment/models/shipment_response/shipment_response.dart';
import 'package:haruviet/data/reponsitory/shipment/shipment_repository.dart';
import 'package:haruviet/database_local/product/cart_database_v2.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/cart/checkout/widgets/checkout_params.dart';
import 'package:provider/provider.dart';

import 'checkout_state.dart';

class CheckOutBloc extends BaseBloc<CheckOutState> {
  final BuildContext context;

  CheckOutBloc(this.context) : super(const CheckOutState());
  final AddressRepository _addressRepository = AddressRepository();
  final ShipmentRepository _shipmentRepository = ShipmentRepository();

// totalPrice: totalPrice
  getData(CheckoutParams params) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    final cart = Provider.of<CartProviderV2>(context, listen: false);
    List<CartModelProduct> productsList = [];
    final userInfoLogin = await Preference.getUserInfo();
    final addressShipping = await Preference.getAddressShipping();
    final paymentData = await Preference.getPayment();
    final dataListAddress = await _addressRepository.getListAddressRP(
      authorization: userInfoLogin?.accessToken ?? '',
    );

    productsList = (await CartDatabaseV2().readAllItems());
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
            shippingAddress.add(addressShipping.address1 ?? '');
            break;
          case 1:
            shippingAddress
                .add(splitStringWithComma(addressShipping.address2 ?? '')[1]);
            break;
          case 2:
            shippingAddress
                .add(splitStringWithComma(addressShipping.address2 ?? '')[0]);
            break;
          case 3:
            shippingAddress.add(addressShipping.address3 ?? '');
            break;
          default:
        }
      }
    } else {
      for (var i = 0; i < 4; i++) {
        switch (i) {
          case 0:
            shippingAddress.add(addressShippingDefault?.address1 ?? '');
            break;
          case 1:
            shippingAddress.add(splitStringWithComma(
                addressShippingDefault?.address2 ?? '')[1]);
            break;
          case 2:
            shippingAddress.add(splitStringWithComma(
                addressShippingDefault?.address2 ?? '')[0]);
            break;
          case 3:
            shippingAddress.add(addressShippingDefault?.address3 ?? '');
            break;
          default:
        }
      }
    }
    final shipmentResponse = await _shipmentRepository.shipmentFeeRP(
        request: ShipmentRequest(
      address: shippingAddress[3],
      deliverOption: "none", // xteam or none
      ward: shippingAddress[2],
      district: shippingAddress[1],
      pickDistrict: "Quận 1",
      pickProvince: "Hồ Chí Minh",
      province: shippingAddress[0],
      tags: [
        1,
      ],
      transport: "road", //  or road or fly => fee
      value: totalPrice,
      weight: params.weight.toInt(),
    ));

    if (shipmentResponse.success == true) {
      emit(state.copyWith(
        shipmentResponse: shipmentResponse,
        // shippingFee: shipmentResponse.fee,
      ));
    }

    // end fee shipping method

    emit(state.copyWith(
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

  onChangeSelectedShipment({required int selectedShipment}) {
    emit(state.copyWith(selectedShipment: selectedShipment));
  }

  onChangeShipmentMethod(
      {required ShipmentResponse shipmentResponse,
      required String titleSelected}) {
    emit(state.copyWith(
        shipmentResponse: shipmentResponse, titleSelected: titleSelected));
  }

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
