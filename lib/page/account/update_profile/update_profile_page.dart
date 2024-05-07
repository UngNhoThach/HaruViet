import 'package:eco_app/component/date_picker/form_date_picker.dart';
import 'package:eco_app/component/dropdown/form_address_input.dart';
import 'package:eco_app/component/input/textfiled_input.dart';
import 'package:eco_app/component/loading_scaffold.dart';
import 'package:eco_app/component/radio_button/radio_button.dart';
import 'package:eco_app/component/snackbar/snackbar_bottom.dart';
import 'package:eco_app/helper/base_status_response.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/main.dart';
import 'package:eco_app/page/account/update_profile/widgets/update_profile_params.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'update_profile_bloc.dart';
import 'update_profile_state.dart';

class UpdateProfilePage extends StatefulWidget {
  final UpdateProfileParams params;
  const UpdateProfilePage({
    super.key,
    required this.params,
  });

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late UpdateProfileBloc bloc;

  AutovalidateMode? autovalidateMode;

  // Widget currentPage = const UpdateProfilePage(
  //   params: ,
  //   key: GlobalObjectKey(true),
  // );
  @override
  void initState() {
    super.initState();
    bloc = UpdateProfileBloc()..getData();
  }

  String? _validationEmail(String? email) {
    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email != null) {
      if (email.isEmpty) {
        return 'Email không được trống';
      }
      if (!emailRegExp.hasMatch(email)) {
        return 'Email không đúng định dạng';
      }
    }
    return null;
  }

  String? _validationName(String? name) {
    if (name != null) {
      if (name.isEmpty) {
        return 'Họ và tên không được trống';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listenWhen: (previous, current) =>
            previous.isSubmitSuccess != current.isSubmitSuccess &&
                current.isSubmitSuccess == true ||
            previous.baseStatusResponse != current.baseStatusResponse,
        listener: (context, state) {
          if (state.baseStatusResponse == BaseStatusResponse.susccess ||
              state.isSubmitSuccess) {
            print('thach...success');
            CustomSnackBar.showTop(context, '${state.message}');
            widget.params.onReload.call();
            context.justBack();
          } else if (state.baseStatusResponse == BaseStatusResponse.failure) {
            CustomSnackBar.showTop(context, '${state.message}');
          }
        },
        child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  color: colorBlack,
                  onPressed: () {
                    context.justBack();
                  },
                ),
                elevation: 0.0,
                backgroundColor: colorTransparent,
                title: Text(
                  'Thông tin tài khoản',
                  style: textTheme.titleMedium?.copyWith(
                      color: colorBlack, fontWeight: FontWeight.bold),
                ),
              ),
              //LoadingScaffold
              body: LoadingScaffold(
                isLoading: state.isLoading,
                child: Center(
                  key: ObjectKey(state.isLoading),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              state.userInfoLogin?.avatar == null ||
                                      state.userInfoLogin?.avatar == ''
                                  ? CircleAvatar(
                                      radius: 38.r,
                                      backgroundColor: colorBlueGray02,
                                      child: CircleAvatar(
                                          radius: 40.r,
                                          backgroundColor: colorBlueGray02,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(),
                                          )),
                                    )
                                  : CircleAvatar(
                                      radius: 38.r,
                                      backgroundColor: Colors.white70,
                                      child: CircleAvatar(
                                          radius: 40.r,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400,
                                                      width: 2.w),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(state
                                                              .userInfoLogin
                                                              ?.avatar ??
                                                          ''),
                                                      fit: BoxFit.contain)),
                                            ),
                                          )),
                                    ),
                              spaceW16,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          state.userInfoLogin?.name ?? '',
                                          // textTheme.bodyMedium
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: colorBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    spaceH6,
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            state.userInfoLogin?.email ?? '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: colorGray04,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              spaceH20,
                              TextFiledInputText(
                                initialText: state.firstName,
                                validator: _validationName,
                                keyboardType: TextInputType.name,
                                icon: const Icon(
                                  Icons.person,
                                ),
                                hintext: 'Tên',
                                //     'first name',
                                onChanged: (firstName) {
                                  bloc.onChangeFirstName(firstName);
                                },
                                isClear: true,
                              ),
                              spaceH16,
                              TextFiledInputText(
                                initialText: state.lastName,
                                validator: _validationName,
                                icon: const Icon(
                                  Icons.person,
                                ),
                                hintext: 'Họ',
                                //     'last name',
                                onChanged: (lastName) {
                                  bloc.onChangeLastName(lastName);
                                },
                                isClear: true,
                              ),
                              state.userInfoLogin?.email == null ||
                                      state.userInfoLogin?.email == ''
                                  ? spaceH12
                                  : space0,
                              state.userInfoLogin?.email == null ||
                                      state.userInfoLogin?.email == ''
                                  ? TextFiledInputText(
                                      validator: _validationEmail,
                                      icon: const Icon(
                                        Icons.email_outlined,
                                      ),
                                      hintext: 'Nhập email',
                                      onChanged: (email) {
                                        bloc.onChangeEmail(email);
                                      },
                                      isClear: true,
                                    )
                                  : space0,
                              spaceH16,
                              TextFiledInputText(
                                initialText: state.phone,
                                keyboardType: TextInputType.number,
                                validator: _validationName,
                                icon: const Icon(
                                  Icons.phone,
                                ),
                                hintext: 'Số điện thoại',
                                //     'last name',
                                onChanged: (phone) {
                                  bloc.onChangePhone(phone);
                                },
                                isClear: true,
                              ),
                              spaceH16,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: colorGray02)),
                                    child: RadioListSelect(
                                      isVertical: true,
                                      items: const [
                                        'Nam',
                                        'Nữ',
                                      ],
                                      currentIndex: state.typeSex,
                                      onSelectedIndex: (index) {
                                        if (index != null) {
                                          bloc.onChangSex(index);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              spaceH16,
                              Column(
                                children: [
                                  FormAddressInput(
                                    key: ObjectKey(state.addressUserData
                                        .temporaryResidenceAddress),
                                    isDisplayTitle: false,
                                    title: 'Địa chỉ',
                                    initialText: state.addressUserData
                                        .temporaryResidenceAddress?.fullAddress,
                                    onChanged: (value) {
                                      bloc.onChangeTemporaryResidenceAddressUser(
                                          temporaryResidenceAddress: value);
                                    },
                                  ),
                                ],
                              ),
                              spaceH16,
                              FormDatePicker(
                                key: ObjectKey(state.birthDay),
                                labelText: 'Ngày sinh',
                                isRequired: false,
                                max: DateTime.now(),
                                initialDate: state.birthDay,
                                onChanged: (date) {
                                  bloc.onChangeBirthDay(date);
                                },
                              ),
                              spaceH20,
                              _button(context, color: colorMain, onTap: () {
                                bloc.state.isValid
                                    ? bloc.onSubmit()
                                    : CustomSnackBar.showTop(context,
                                        'Vui lòng điền đầy đủ thông tin!');
                              }, title: 'CẬP NHẬP'),
                              spaceH12,
                              _button(context,
                                  color: colorWhite,
                                  onTap: () {},
                                  title: 'XOÁ TÀI KHOẢN',
                                  colorText: colorMain,
                                  border: Border.all(color: colorGray04)),
                              spaceH72,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _button(
    BuildContext context, {
    required String title,
    required void Function()? onTap,
    required Color color,
    Color? colorText,
    BoxBorder? border,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        height: 42,
        decoration: BoxDecoration(
            border: border,
            color: color,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              color: colorText ?? colorWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonItem(
      String imagePath, String buttonName, double size, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 56,
        child: Card(
          elevation: 8,
          color: colorGray04,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                width: 1,
                color: Colors.grey,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   imagePath,
              //   height: size,
              //   width: size,
              // ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(String name, bool obsecureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      height: 55,
      child: TextFormField(
        obscureText: obsecureText,
        style: const TextStyle(
          fontSize: 17,
          color: colorBlack,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 14,
            color: colorBlack,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton(String name) {
    return InkWell(
      onTap: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const HomePage()),
            (route) => false);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          color: colorMain,
          borderRadius: BorderRadius.circular(20),
          // gradient: const LinearGradient(colors: [
          //   Color(0xFFFD746C),
          //   Color(0xFFFF9068),
          //   Color(0xFFFD746C),
          // ]),
        ),
        child: Center(
          child: Text(name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
        ),
      ),
    );
  }
}
