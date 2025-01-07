import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/reponsitory/shipment/payment_response/data_payment.dart';
import 'package:haruviet/page/shipment/shipment_state.dart';
import 'package:haruviet/page/shipment/widgets/shipment_params.dart';

class ShipmentBloc extends BaseBloc<ShipmentState> {
  // final ShipmentRepository _shipmentRepository = ShipmentRepository();
  ShipmentBloc() : super(const ShipmentState());
  getData({
    required ShipmentParams params,
  }) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    // final List<ShipmentResponse> listShipmentResponse = [];

    // Future<ShipmentResponse> getShipmentResponse(
    //     {required List<Map<String, String>> deliverOption,
    //     required int i}) async {
    //   final shipmentResponse = await _shipmentRepository.shipmentFeeRP(
    //       request: ShipmentRequest(
    //     deliverOption: deliverOption[i]['key'], // xteam or none
    //     pickDistrict: "Quận 1",
    //     pickProvince: "Hồ Chí Minh",
    //     tags: [1],
    //     transport: deliverOption[i]['value'], //  or road or fly => fee
    //   ));
    //   return shipmentResponse;
    // }

    // shippingFee

    emit(state.copyWith(
      selectedItemShipment: params.selectedItemShipment,
      listShipmentData: params.data,
    ));

    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onUpdateIdShipping({required DataListAddress addressShipping}) async {
    await Preference.setAddressShipping(addressShipping);
  }

  onSelect({required DataPayment selectedItemShipment}) {
    emit(state.copyWith(selectedItemShipment: selectedItemShipment));
  }
}
