import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/shipment/payment_response/data_payment.dart';

part 'shipment_state.g.dart';

@CopyWith()
class ShipmentState extends BaseState {
  final bool isLoading;
  final DataPayment? selectedItemShipment;
  final List<DataPayment>? listShipmentData;

  const ShipmentState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.selectedItemShipment,
    this.listShipmentData = const [],
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
