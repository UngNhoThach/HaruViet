import 'package:haruviet/base/base_state.dart';
import 'package:haruviet/component/input/textfiled_input.dart';
import 'package:haruviet/component/input/password_input.dart';
import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/database_local/product/models/count_model.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/signin/signin_bloc.dart';
import 'package:haruviet/page/account/signin/signin_state.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/account/signup/signup_page.dart';
import 'package:haruviet/page/account/signup/widgets/sigup_status.dart';
import 'package:haruviet/page/home/home_page.dart';
import 'package:haruviet/page/main_screen/main_screen_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatefulWidget {
  final SignInParams params;
  const SignInPage({Key? key, required this.params}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState
    extends BaseViewState<SignInState, SignInBloc, SignInPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode;
  final _counterModel = CounterModel();

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

  @override
  Widget buildLoadedView(BuildContext context, SignInState state) {
    return BlocListener<SignInBloc, SignInState>(
      listenWhen: (previous, current) =>
          previous.isSubmitSuccess != current.isSubmitSuccess &&
              current.isSubmitSuccess == true ||
          previous.sigupStatus != current.sigupStatus,
      listener: (context, state) {
        if (state.sigupStatus == SigupStatus.sigupSuccess ||
            state.isSubmitSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreenPage()),
              (route) => false);
        } else if (state.sigupStatus == SigupStatus.sigupFailure) {
          CustomSnackBar.showTop(context, '${state.message}', null);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: colorBlack,
            ),
            onPressed: () {
              context.justBack();
            },
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: colorTransparent,
          title: Text(
            'Đăng nhập',
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
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo/logo.png',
                          height: 120.r, width: 120.r, fit: BoxFit.cover),
                      spaceH36,
                      TextFiledInput(
                        validator: _validationEmail,
                        keyboardType: TextInputType.emailAddress,
                        icon: const Icon(
                          Icons.email_outlined,
                        ),
                        hintext: 'Email hoặc số điện thoại',
                        onChanged: (email) {
                          bloc.onChangeEmail(email);
                        },
                        isClear: true,
                      ),
                      spaceH12,
                      PasswordInputV2(
                        // enabled: state.isLoading ? false : true,
                        hintText: 'Nhập mật khẩu',
                        onChanged: (password) {
                          bloc.onChangePassword(password);
                        },
                        isClear: true,
                      ),
                      spaceH20,
                      _button(context, state),
                      spaceH20,
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
                            color: Colors.grey, // Màu của đường kẻ
                          ),
                        ],
                      ),
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
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(12)),
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
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/google.png',
                                  height: 30.r, width: 30.r, fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      spaceH20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Bạn chưa có tài khoản ?",
                            style: TextStyle(
                              color: colorGray04,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          const SignUpPage()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                " Đăng ký",
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
                      GestureDetector(
                        onTap: () {
                          routeService.pushNamed(Routes.forgetPassWordPage);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Quên mật khẩu ?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: colorPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ),
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

  Widget _button(
    BuildContext context,
    SignInState state,
  ) {
    return InkWell(
      onTap: () {
        // state.isLoading == false
        //     ? _showDefaultLoading()
        //     :
        FocusScope.of(context).requestFocus(FocusNode());
        final isValidForm = _formKey.currentState?.validate();
        if (isValidForm == true) {
          bloc.onSubmit();
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
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Center(
          child: Text(
            'ĐĂNG NHẬP',
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
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        // controller: controller,
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
              width: 1,
              color: colorBlack,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: colorBlack,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton(String name) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const HomePage()),
            (route) => false);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
        ),
      ),
    );
  }

  @override
  SignInBloc createState() {
    return bloc = SignInBloc(context);
  }
}
