import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/customers/models/address_user_response.dart';
import 'package:eco_app/data/reponsitory/customers/models/user_update_info_response/data_user_update_info.dart';
import 'package:eco_app/data/data_local/user_state.dart';
import 'package:eco_app/helper/base_status_response.dart';

part 'update_profile_state.g.dart';

@CopyWith()
class UpdateProfileState extends BaseState {
  final DataUserUpdateInfo? userInfo;
  final bool isLoading;
  final bool isSubmitSuccess;
  final String? address;
  final String? message;
  final BaseStatusResponse baseStatusResponse;
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
  final AddressUser addressUserData;
  final int? typeSex;
  final String? sex;
  final DateTime? birthDay;
  final DataUserUpdateInfo? dataUpdate;

  final UserInfoLogin? userInfoLogin;
  const UpdateProfileState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.userInfo,
    this.email,
    this.baseStatusResponse = BaseStatusResponse.initial,
    this.dataUpdate,
    this.userName,
    this.firstName,
    this.lastName,
    this.message,
    this.address,
    this.address1,
    this.address1ID,
    this.address2,
    this.address2ID,
    this.address3,
    this.address3ID,
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
