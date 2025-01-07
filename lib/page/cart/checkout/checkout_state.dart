import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/create_order_request.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/data_order.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/data_total.dart';
import 'package:haruviet/api/services/cart_orders/models/create_order_request/item_detail.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/get_cart_order_response/get_cart_order_response.dart';
import 'package:haruviet/data/reponsitory/shipment/payment_response/data_payment.dart';
import 'package:haruviet/data/reponsitory/shipment/payment_response/payment_response.dart';
part 'checkout_state.g.dart';

@CopyWith()
class CheckOutState extends BaseState {
  final String codeSelected;
  final PaymentResponse? checkShippingFreeResponse;
  final bool isChangeShippingFree;
  final DataPayment? dataFeeShipping;
  final UserState? userInfoLogin;
  final int discoutTotal;
  final List<ItemDetail>? itemDetail;
  final List<DataTotal>? dataTotal;
  final DataOrder? dataOrder;
  final String? comment;
  final PaymentResponse? paymentResponse;
  final bool isLoading;
  final bool isLoadingCreateOrders;
  final int selectedShipment;
  final List<GetCartOrderResponse> productsList;
  final CreateOrderRequest? createOrderRequest;
  // final ShipmentFee? shippingFee;
  final String? deliverOption;
  final String? transport;
  final List<String> shippingAddress;
  final int? totalPrice;
  final String? keyPaymentMethod;
  final String? valueShippingMethod;
  final DataListAddress? addressShipping;
  final List<DataListAddress>? listAddresses;
  final String? idAddressShipping;
  const CheckOutState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.dataFeeShipping,
    this.codeSelected = '',
    this.isChangeShippingFree = false,
    this.checkShippingFreeResponse,
    this.userInfoLogin,
    this.dataOrder,
    this.discoutTotal = 0,
    this.dataTotal,
    this.itemDetail,
    this.comment,
    this.isLoadingCreateOrders = false,
    this.createOrderRequest,
    this.selectedShipment = 0,
    this.paymentResponse,
    this.shippingAddress = const [],
    this.deliverOption,
    this.transport,
    this.addressShipping,
    this.totalPrice,
    //   this.shippingFee,
    this.keyPaymentMethod,
    this.valueShippingMethod,
    this.listAddresses = const [],
    this.productsList = const [],
    this.idAddressShipping,
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
