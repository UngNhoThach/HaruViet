import 'package:eco_app/base/base_bloc.dart';
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

  onChangeLocationDefault(int isLocationDefault) {
    emit(state.copyWith(
      isLocationDefault: isLocationDefault,
    ));
  }
}
