import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/shipment/models/shipment_response/shipment_fee.dart';
import 'package:haruviet/data/reponsitory/shipment/models/shipment_response/shipment_response.dart';

part 'shipment_state.g.dart';

@CopyWith()
class ShipmentState extends BaseState {
  final bool isLoading;
  final String? deliverOption;
  final List<ShipmentResponse> listShipmentResponse;
  final ShipmentResponse? shipmentResponse;

  final List<String> titleDeliverOption;
  final ShipmentFee? shippingFee;
  final String? titleSelected;
  final int? selectedShipment;
  const ShipmentState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.shippingFee,
    this.shipmentResponse,
    this.titleSelected,
    this.titleDeliverOption = const [],
    this.listShipmentResponse = const [],
    this.deliverOption,
    this.selectedShipment,
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
