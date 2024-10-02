import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/reponsitory/shipment/models/shipment_response/shipment_fee.dart';
import 'package:haruviet/data/reponsitory/shipment/models/shipment_response/shipment_response.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';

part 'checkout_state.g.dart';

@CopyWith()
class CheckOutState extends BaseState {
  final bool isLoading;
  final int selectedShipment;
  final List<CartModelProduct> productsList;
  // final ShipmentFee? shippingFee;
  final String? deliverOption;
  final String? transport;
  final String? titleSelected;
  final ShipmentResponse? shipmentResponse;
  final List<String> shippingAddress;
  final int? totalPrice;
  final int indexShippingMethod;
  final String? valueShippingMethod;
  final DataListAddress? addressShipping;
  final List<DataListAddress>? listAddresses;
  final String? idAddressShipping;
  const CheckOutState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.titleSelected,
    this.selectedShipment = 0,
    this.shipmentResponse,
    this.shippingAddress = const [],
    this.deliverOption,
    this.transport,
    this.addressShipping,
    this.totalPrice,
    //   this.shippingFee,
    this.indexShippingMethod = 0,
    this.valueShippingMethod,
    this.listAddresses = const [],
    this.productsList = const [],
    this.idAddressShipping,
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
