import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/data_local/user_state.dart';

part 'add_address_state.g.dart';

@CopyWith()
class AddNewAddressState extends BaseState {
  final bool isLoading;
  final UserState? userInfoLogin;
  final bool isSubmitSuccess;
  final bool textBtnswitchState;
  final int? isLocationDefault;
  final String? house;
  final String? ward;
  final String? district;
  final String? province;
  final String? street;
  final String? idProvince;
  final String? idDistrict;
  final String? idWard;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? name;
  final String? phone;
  final String? accessToken;
  final String? message;
  final DataListAddress? dataListAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AddNewAddressState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.createdAt,
    this.updatedAt,
    this.dataListAddress,
    this.userInfoLogin,
    this.accessToken,
    this.message,
    this.house,
    this.district,
    this.province,
    this.idWard,
    this.idDistrict,
    this.idProvince,
    this.street,
    this.ward,
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
        phone!.isNotEmpty;
    //&&
    // address1 != null &&
    // address1!.isNotEmpty;
  }
}
