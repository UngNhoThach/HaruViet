import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';

part 'address_state.g.dart';

@CopyWith()
class AddressState extends BaseState {
  final bool isLoading;
  final bool textBtnswitchState;
  final int? isLocationDefault;
  final String? address;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? address1ID;
  final String? address2ID;
  final String? address3ID;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;

  final String? name;
  final String? phone;

  const AddressState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.address,
    this.address1,
    this.address2,
    this.address3,
    this.address1ID,
    this.address2ID,
    this.address3ID,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.name,
    this.phone,
    this.isLoading = false,
    this.isLocationDefault,
    this.textBtnswitchState = false,
  }) : super(viewState, errorMsg);
}
