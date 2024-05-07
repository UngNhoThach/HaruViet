import 'package:eco_app/data/reponsitory/setting/item_base_response.dart';
import 'package:eco_app/data/reponsitory/setting/setting_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/select_address_params.dart';
import 'models/select_address_step.dart';
import 'select_address_state.dart';

class SelectAddressBloc extends Cubit<SelectAddressState> {
  final SettingRepository _settingRepository = SettingRepository();

  SelectAddressBloc() : super(const SelectAddressState());

  getData(SelectAddressParams? params) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    var dataList = <ItemBaseResponse>[];

    if (params?.step == SelectAddressStep.district &&
        params?.dataAddress != null &&
        params?.dataAddress?.city != null) {
      dataList = await _settingRepository.getDistrictListRP(
          countryId: params?.dataAddress?.city?.id ?? 1);
    } else if (params?.step == SelectAddressStep.ward &&
        params?.dataAddress != null &&
        params?.dataAddress?.district != null) {
      dataList = await _settingRepository.getWardListRP(
          districtId: params?.dataAddress?.district?.id ?? 1);
    } else {
      dataList = await _settingRepository.getCountryListRP();
    }

    emit(state.copyWith(
      step: params?.step ?? SelectAddressStep.city,
      dataAddress: params?.dataAddress,
      dataList: dataList,
      dataSearchList: dataList,
      isLoading: false,
    ));
  }

  onSelect(ItemBaseResponse item) async {
    emit(state.copyWith(
      isSelect: false,
    ));

    var step = state.step;
    var dataAddress = state.dataAddress;

    if (state.step == SelectAddressStep.city) {
      step = SelectAddressStep.district;
      dataAddress = dataAddress.copyWith(
        city: item,
      );
    } else if (state.step == SelectAddressStep.district) {
      step = SelectAddressStep.ward;
      dataAddress = dataAddress.copyWith(
        district: item,
      );
    } else if (state.step == SelectAddressStep.ward) {
      step = SelectAddressStep.address;
      dataAddress = dataAddress.copyWith(
        ward: item,
      );

      dataAddress = dataAddress.copyWith(
        fullAddress: dataAddress.toString(),
      );
    }

    emit(state.copyWith(
      step: step,
      dataAddress: dataAddress,
      isSelect: true,
    ));
  }

  onSubmit(String? address) async {
    emit(state.copyWith(
      isSubmitSuccess: false,
    ));

    var dataAddress = state.dataAddress;
    dataAddress = dataAddress.copyWith(
      address: address,
    );

    dataAddress = dataAddress.copyWith(
      fullAddress: dataAddress.toString(),
    );

    emit(state.copyWith(
      dataAddress: dataAddress,
      isSubmitSuccess: true,
    ));
  }

  onSearch(String keyword) {
    final dataList = List<ItemBaseResponse>.from(state.dataList);

    var dataSearchList = <ItemBaseResponse>[];

    if (keyword.isEmpty) {
      dataSearchList = dataList;
    } else {
      dataSearchList = dataList
          .where((element) => (element.name ?? '')
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }

    emit(state.copyWith(
      dataSearchList: dataSearchList,
    ));
  }
}
