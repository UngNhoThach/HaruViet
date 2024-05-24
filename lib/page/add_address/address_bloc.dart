import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/reponsitory/customers/models/address_response.dart';
import 'package:eco_app/page/add_address/address_state.dart';

class AddressBloc extends BaseBloc<AddressState> {
  AddressBloc() : super(const AddressState());
  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onChangeBtnswitchState(bool textBtnswitchState) {
    emit(state.copyWith(
      textBtnswitchState: textBtnswitchState,
    ));
  }

  onChangeTemporaryResidenceAddressUser({
    AddressResponse? temporaryResidenceAddress,
  }) {
    // var addressUserData = state.addressUserData;
    // addressUserData = addressUserData.copyWith(
    //   permanentAddress: addressUserData.permanentAddress,
    //   temporaryResidenceAddress: temporaryResidenceAddress,
    //   hometownAddress: addressUserData.hometownAddress,
    //   birthCertificateIssuanceAddress:
    //       addressUserData.birthCertificateIssuanceAddress,
    // );
    emit(state.copyWith(
      //   addressUserData: addressUserData,
      address: temporaryResidenceAddress?.fullAddress,
      address1: temporaryResidenceAddress?.city?.name,
      address2: temporaryResidenceAddress?.district?.name,
      address3: temporaryResidenceAddress?.ward?.name,
      address1ID: temporaryResidenceAddress?.city?.id.toString(),
      address2ID: temporaryResidenceAddress?.district?.id.toString(),
      address3ID: temporaryResidenceAddress?.ward?.id.toString(),
    ));
  }

  onChangeLocationDefault(int isLocationDefault) {
    emit(state.copyWith(
      isLocationDefault: isLocationDefault,
    ));
  }
}
