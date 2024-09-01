import 'package:haruviet/base/base_state.dart';
import 'package:haruviet/component/input/textfiled_input.dart';
import 'package:haruviet/component/input/password_input.dart';
import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/data/reponsitory/normal_response/customer_response/normal_error.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/main.dart';
import 'package:haruviet/page/account/phone_authen/widgets/phone_authen_params.dart';
import 'package:haruviet/page/account/signup/signup_bloc.dart';
import 'package:haruviet/page/account/signup/signup_state.dart';
import 'package:haruviet/page/account/signup/widgets/verify_status.dart';
import 'package:haruviet/page/main_screen/main_screen_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState
    extends BaseViewState<SignupState, SignupBloc, SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode;

  Widget currentPage = const SignUpPage(
    key: GlobalObjectKey(true),
  );

  String? _validationEmail(String? email) {
    bool isEmailValid(String email) {
      RegExp regex = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      return regex.hasMatch(email);
    }

    // check is phone number
    bool isValidPhone(String phone) {
      RegExp regex = RegExp(r'((\+84|84|0)+([3|5|7|8|9])+([0-9]{8})\b)');
      return regex.hasMatch(phone);
    }

    if (email == null || email.isEmpty) {
      return 'Vui lòng điền email hoặc số điện thoại';
    } else if (isEmailValid(email)) {
      return null;
    } else if (isValidPhone(email)) {
      return null;
    } else {
      return 'Email hoặc số điện thoại không hợp lệ';
    }
  }

  // validator from sever
  String? _validationEmailSever(String? email, String? error) {
    if (error != null || error != '' || email != null) {
      return error ?? '';
    } else {
      return null;
    }
  }

  String? _validationName(String? name) {
    if (name != null) {
      if (name.isEmpty) {
        return 'Họ và tên không được trống';
      }
    }
    return null;
  }

  Widget _button(
    BuildContext context,
    SignupState state,
  ) {
    return InkWell(
      onTap: () async {
        final isValidForm = _formkey.currentState?.validate();
        if (isValidForm == true) {
          bloc.onSignup();
        } else {
          setState(() {
            autovalidateMode = AutovalidateMode.onUserInteraction;
          });
        }
      },
      child: Container(
        width: 1.sw,
        height: 36.h,
        decoration: BoxDecoration(
            color: colorMain, borderRadius: BorderRadius.circular(12.r)),
        child: Center(
          child: Text(
            'ĐĂNG KÝ',
            style: textTheme.bodyMedium?.copyWith(
              color: colorWhite,
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

  @override
  SignupBloc createState() {
    return bloc = SignupBloc();
  }

  @override
  Widget buildLoadedView(BuildContext context, SignupState state) {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (previous, current) =>
          previous.verifyStatus != current.verifyStatus ||
          previous.isSubmitSuccess != current.isSubmitSuccess,
      listener: (context, state) {
        if (state.isSubmitSuccess == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreenPage()),
              (route) => false);
        }
        if (state.verifyStatus == VerifyStatus.verifyFailure) {
          setState(() {});
        }
        if (state.verifyStatus == VerifyStatus.wattingCheck) {
          routeService.pushNamed(Routes.phoneAuthPage,
              arguments: PhoneAuthParams(
                  firstName: state.userNameChange ?? '',
                  password: state.passwordChange ?? '',
                  passwordConfirmation: state.rePasswordChange ?? '',
                  timeout: state.timeout ?? 0,
                  username: state.emailChange ?? ''));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: colorBlack,
            onPressed: () {
              context.justBack();
            },
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: colorTransparent,
          title: Text(
            'Đăng ký',
            style: textTheme.titleMedium
                ?.copyWith(color: colorBlack, fontWeight: FontWeight.bold),
          ),
        ),
        body: LoadingScaffold(
          isLoading: state.isLoading,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Form(
                key: _formkey,
                autovalidateMode: autovalidateMode,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo_2.png',
                          height: 120.r, width: 120.r, fit: BoxFit.cover),
                      spaceH20,
                      BlocSelector<SignupBloc, SignupState, NormalError>(
                        selector: (state) {
                          return state.errors == null
                              ? NormalError(email: null, phone: null)
                              : state.errors!;
                        },
                        builder: (context, errors) {
                          return Column(
                            children: [
                              TextFiledInput(
                                validator: _validationName,
                                keyboardType: TextInputType.name,
                                icon: const Icon(
                                  Icons.person,
                                ),
                                hintext: 'Họ và tên',
                                onChanged: (name) {
                                  bloc.onChangeUserName(name);
                                },
                                isClear: true,
                              ),
                              spaceH12,
                              TextFiledInput(
                                validator: (input) {
                                  if (errors.phone == null &&
                                      errors.email == null) {
                                    return _validationEmail(input);
                                  } else if (errors.email != null) {
                                    return _validationEmailSever(
                                        input, errors.email);
                                  }
                                  return _validationEmailSever(
                                      input, errors.phone);
                                },
                                keyboardType: TextInputType.emailAddress,
                                icon: const Icon(
                                  Icons.email_outlined,
                                ),
                                hintext: 'Email hoặc số điện thoại',
                                onChanged: (email) {
                                  bloc.checkTextValidator(email);
                                },
                                isClear: true,
                              ),
                              spaceH12,
                              PasswordInputV2(
                                validator: (password) {
                                  if (password == null || password.isEmpty) {
                                    return "Mật khẩu không được để trống";
                                  } else if (password.length < 6) {
                                    return "Mật khẩu phải có ít nhất 6 ký tự";
                                  }
                                  return null;
                                },
                                hintText: 'Mật khẩu',
                                onChanged: (password) {
                                  bloc.onChangePassword(password);
                                },
                                isClear: true,
                              ),
                              spaceH12,
                              PasswordInputV2(
                                validator: (rePassword) {
                                  final password = state.passwordChange;
                                  if (rePassword != password) {
                                    return "Mật khẩu không trùng khớp";
                                  }
                                  return null;
                                },
                                hintText: 'Nhập lại mật khẩu',
                                onChanged: (rePassword) {
                                  bloc.onChangeRePassword(rePassword);
                                },
                                isClear: true,
                              ),
                            ],
                          );
                        },
                      ),
                      spaceH20,
                      _button(context, state),
                      spaceH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              bloc.signSocial(2);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorMain),
                                  borderRadius: BorderRadius.circular(12.r)),
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/facebook.png',
                                  height: 30.r, width: 30.r, fit: BoxFit.cover),
                            ),
                          ),
                          spaceW30,
                          GestureDetector(
                            onTap: () {
                              bloc.signSocial(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorMain),
                                  borderRadius: BorderRadius.circular(12.r)),
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/google.png',
                                  height: 30.r, width: 30.r, fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      spaceH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 50,
                            color: Colors.grey, // Màu của đường kẻ
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Hoặc đăng nhập bằng",
                              style: TextStyle(
                                color: colorGray04,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 50,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      spaceH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Đã có tài khoản ?",
                            style: TextStyle(
                              color: colorGray04,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.justBack();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                " Đăng nhập",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: colorPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      spaceH30,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
