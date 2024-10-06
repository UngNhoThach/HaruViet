import 'package:haruviet/api/services/shipment/models/shipment_request/shipment_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/reponsitory/shipment/models/shipment_response/shipment_response.dart';
import 'package:haruviet/data/reponsitory/shipment/shipment_repository.dart';
import 'package:haruviet/page/shipment/shipment_state.dart';
import 'package:haruviet/page/shipment/widgets/shipment_params.dart';

class ShipmentBloc extends BaseBloc<ShipmentState> {
  final ShipmentRepository _shipmentRepository = ShipmentRepository();
  ShipmentBloc() : super(const ShipmentState());
  getData({
    required ShipmentParams params,
  }) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final List<ShipmentResponse> listShipmentResponse = [];

    List<Map<String, String>> deliverOption = [
      {
        "key": "none",
        "value": 'road',
      },
      {
        "key": "none",
        "value": 'fly',
      },
      {
        "key": "xteam",
        "value": 'fly',
      },
      // {
      //   "key": "xteam",
      //   "value": 'fly',
      // },
    ];
    List<String> titleDeliverOption = [
      'Giao hàng tiêu chuẩn (đường bộ)',
      'Giao hàng tiêu chuẩn (máy bay)',
      'Giao hàng nhanh hỏa tốc',
    ];

    Future<ShipmentResponse> getShipmentResponse(
        {required List<Map<String, String>> deliverOption,
        required int i}) async {
      final shipmentResponse = await _shipmentRepository.shipmentFeeRP(
          request: ShipmentRequest(
        address: params.shippingAddress[3],
        deliverOption: deliverOption[i]['key'], // xteam or none
        ward: params.shippingAddress[2],
        district: params.shippingAddress[1],
        pickDistrict: "Quận 1",
        pickProvince: "Hồ Chí Minh",
        province: params.shippingAddress[0],
        tags: [1],
        transport: deliverOption[i]['value'], //  or road or fly => fee
        value: params.totalPrice,
        weight: params.weight.toInt(),
      ));
      return shipmentResponse;
    }

    // get the shipment response for methods
    for (var i = 0; i < deliverOption.length; i++) {
      final ShipmentResponse value =
          await getShipmentResponse(deliverOption: deliverOption, i: i);
      if (value.success == true) {
        listShipmentResponse.add(value);
      }
    }

    // shippingFee

    emit(state.copyWith(
        listShipmentResponse: listShipmentResponse,
        selectedShipment: params.selectedShipment,
        shipmentResponse: params.shipmentResponse,
        titleSelected: params.titleSelected,
        titleDeliverOption: titleDeliverOption));

    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onUpdateIdShipping({required DataListAddress addressShipping}) async {
    await Preference.setAddressShipping(addressShipping);
  }

  onSelect(
      {required int selectedShipment,
      required ShipmentResponse shipmentResponse,
      required String titleSelected}) {
    emit(state.copyWith(
        selectedShipment: selectedShipment,
        shipmentResponse: shipmentResponse,
        titleSelected: titleSelected));
  }
}
