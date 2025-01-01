import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/customers/models/address_user_response.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/helper/base_status_response.dart';

part 'update_profile_state.g.dart';

@CopyWith()
class UpdateProfileState extends BaseState {
  final bool isLoading;
  final bool isSubmitSuccess;
  final String? message;
  final BaseStatusResponse baseStatusResponse;
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
  final String? addressId;
  final String? name;
  final String? phone;
  final AddressUser addressUserData;
  final int? typeSex;
  final String? sex;
  final DateTime? birthDay;
  final UserState? userInfo;

  final UserState? userInfoLogin;
  const UpdateProfileState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.userInfo,
    this.addressId,
    this.house,
    this.district,
    this.province,
    this.idWard,
    this.idDistrict,
    this.idProvince,
    this.street,
    this.ward,
    this.email,
    this.baseStatusResponse = BaseStatusResponse.initial,
    this.userName,
    this.firstName,
    this.lastName,
    this.message,
    this.addressUserData = const AddressUser(),
    this.isLoading = false,
    this.typeSex,
    this.phone,
    this.name,
    this.sex,
    this.birthDay,
    this.userInfoLogin,
    this.isSubmitSuccess = false,
  }) : super(viewState, errorMsg);

  bool get isValid {
    // final List<bool> b = listConstruction.map((e) {
    //   if (e.giaTri != null &&
    //       e.tgBatDau != null &&
    //       e.tgKetThuc != null &&
    //       e.tgDuPhong != null) {
    //     return true;
    //   }
    //   return false;
    // }).toList();
    // final List<bool> a = listPosition.map((e) {
    //   if (e.tcnSl != null &&
    //       e.tcnTgnv != null &&
    //       e.tchtSl != null &&
    //       e.tchtTgnv != null &&
    //       e.tctSl != null &&
    //       e.tctTgnv != null) {
    //     return true;
    //   }
    //   return false;
    // }).toList();

    return firstName != null &&
        lastName != null &&
        phone != null &&
        typeSex != null &&
        birthDay != null &&
        email != null &&
        addressUserData.temporaryResidenceAddress != null;
  }
}
