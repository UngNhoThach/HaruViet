import 'package:haruviet/component/date_picker/form_date_picker.dart';
import 'package:haruviet/component/dropdown/form_address_input.dart';
import 'package:haruviet/component/input/textfiled_input.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/radio_button/radio_button.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/helper/base_status_response.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/main.dart';
import 'package:haruviet/page/account/update_profile/widgets/update_profile_params.dart';
import 'package:haruviet/theme/typography.dart';
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
  // variables and functions
  late UpdateProfileBloc bloc;
  final _formkey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode;

  // validation
  String? _validatorPhone(String? value) {
    if (value == null || value.isEmpty || !isValidPhone(value)) {
      return 'không hợp lệ';
    }
    return null;
  }

  bool isValidPhone(String phone) {
    RegExp regex = RegExp(r'((\+84|84|0)+([3|5|7|8|9])+([0-9]{8})\b)');
    return regex.hasMatch(phone);
  }

  @override
  void initState() {
    bloc = UpdateProfileBloc()..getData();

    super.initState();
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

  String? _validation(String? name) {
    if (name != null) {
      if (name.isEmpty) {
        return 'Không được bỏ trống';
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
            CustomSnackBar.showTop(context, '${state.message}', null);
            widget.params.onReload.call();
            context.justBack();
          } else if (state.baseStatusResponse == BaseStatusResponse.failure) {
            CustomSnackBar.showTop(context, '${state.message}', null);
          }
        },
        child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: () {
                    context.justBack();
                  },
                ),
                elevation: 0.0,
                title: Text(
                  'Thông tin tài khoản',
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              //LoadingScaffold
              body: state.isLoading
                  ? const LoadingLogo()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // state.userInfo?.avatar == null ||
                                  //         state.userInfo?.avatar == ''
                                  //     ? CircleAvatar(
                                  //         radius: 38.r,
                                  //         backgroundColor: colorBlueGray02,
                                  //         child: CircleAvatar(
                                  //             radius: 40.r,
                                  //             backgroundColor: colorBlueGray02,
                                  //             child: AspectRatio(
                                  //               aspectRatio: 1,
                                  //               child: Container(),
                                  //             )),
                                  //       )
                                  //     :
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: CircleAvatar(
                                      radius: 56.r,
                                      backgroundColor: Colors.white70,
                                      child: CircleAvatar(
                                          radius: 40.r,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
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
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              state.userInfo?.name ?? '',
                                              // textTheme.bodyMedium
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
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
                                                state.userInfo?.email ?? '',
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
                                    isErrorBorder: false,
                                    initialText: state.firstName,
                                    validator: _validation,
                                    keyboardType: TextInputType.name,
                                    icon: const Icon(
                                      Icons.person,
                                    ),
                                    hintext: 'Tên',
                                    //     'first name',
                                    onChanged: (firstName) {
                                      bloc.onChangeFirstName(firstName);
                                    },
                                  ),
                                  spaceH16,
                                  TextFiledInputText(
                                    isErrorBorder: false,

                                    initialText: state.lastName ?? '',
                                    validator: _validation,
                                    icon: const Icon(
                                      Icons.person,
                                    ),
                                    hintext: 'Họ',
                                    //     'last name',
                                    onChanged: (lastName) {
                                      bloc.onChangeLastName(lastName);
                                    },
                                  ),
                                  state.email == null || state.email == ''
                                      ? spaceH12
                                      : space0,
                                  state.email == null || state.email == ''
                                      ? TextFiledInputText(
                                          isErrorBorder: false,
                                          initialText:
                                              state.userInfo?.email ?? '',
                                          validator: _validationEmail,
                                          icon: const Icon(
                                            Icons.email_outlined,
                                          ),
                                          hintext: 'Nhập email',
                                          onChanged: (email) {
                                            bloc.onChangeEmail(email);
                                          },
                                        )
                                      : space0,
                                  spaceH16,
                                  TextFiledInputText(
                                    isErrorBorder: false,
                                    initialText: state.phone ?? '',
                                    keyboardType: TextInputType.number,
                                    validator: _validation,
                                    icon: const Icon(
                                      Icons.phone,
                                    ),
                                    hintext: 'Số điện thoại',
                                    onChanged: (phone) {
                                      bloc.onChangePhone(phone);
                                    },
                                  ),
                                  spaceH16,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border:
                                                Border.all(color: colorGray02)),
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
                                        key: ObjectKey(state.idDistrict),
                                        isDisplayTitle: false,
                                        title: 'Địa chỉ',
                                        initialText: state.district == null
                                            ? null
                                            : '${state.house ?? ''}, ${state.ward ?? ''}, ${state.district ?? ''}, ${state.province ?? ''}',
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
                                  _button(context,
                                      color: Theme.of(context).primaryColor,
                                      onTap: () {
                                    final isValidForm =
                                        _formkey.currentState?.validate();
                                    if (isValidForm == true) {
                                      bloc.onSubmit();
                                    } else {
                                      autovalidateMode =
                                          AutovalidateMode.onUserInteraction;
                                    }
                                  }, title: 'CẬP NHẬP'),
                                  spaceH12,
                                  _button(context,
                                      color: colorWhite,
                                      onTap: () {},
                                      title: 'XOÁ TÀI KHOẢN',
                                      colorText: Theme.of(context).primaryColor,
                                      border: Border.all(color: colorGray04)),
                                  spaceH72,
                                ],
                              ),
                            ],
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
      child: SizedBox(
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
    return SizedBox(
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
            MaterialPageRoute(builder: (builder) => const HaruViet()),
            (route) => false);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
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
