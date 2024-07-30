import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/data_local/user_state.dart';

part 'add_address_state.g.dart';

@CopyWith()
class AddNewAddressState extends BaseState {
  final bool isLoading;
  final UserInfoLogin? userInfoLogin;
  final bool isSubmitSuccess;
  final bool textBtnswitchState;
  final int? isLocationDefault;
  final String? address;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? address4;
  final String? address1ID;
  final String? address2ID;
  final String? address3ID;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? name;
  final String? phone;
  final String? accessToken;
  final String? message;
  final DataListAddress? dataListAddress;

  const AddNewAddressState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.dataListAddress,
    this.userInfoLogin,
    this.accessToken,
    this.message,
    this.address,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
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
    this.isSubmitSuccess = false,
    this.isLocationDefault,
    this.textBtnswitchState = false,
  }) : super(viewState, errorMsg);

  bool get isValid {
    return name != null &&
        name!.isNotEmpty &&
        phone != null &&
        phone!.isNotEmpty &&
        address1 != null &&
        address1!.isNotEmpty;
  }
}
