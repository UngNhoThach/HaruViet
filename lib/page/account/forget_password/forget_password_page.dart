import 'package:haruviet/component/popup/alert/alert_one_button.dart';
import 'package:haruviet/component/input/textfiled_input.dart';
import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/forget_password/forget_password_bloc.dart';
import 'package:haruviet/page/account/forget_password/forget_password_state.dart';
import 'package:haruviet/page/account/reset_password/widgets/reset_password_params.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/account/signup/widgets/sigup_type.dart';
import 'package:haruviet/page/main_screen/main_screen_page.dart';
import 'package:haruviet/page/account/signup/widgets/verify_status.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassWordPage extends StatefulWidget {
  const ForgetPassWordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPassWordPage> createState() => _ForgetPassWordPageState();
}

class _ForgetPassWordPageState extends State<ForgetPassWordPage> {
  // variables and functions
  late ForgetPassWordBloc bloc;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode;

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
  void initState() {
    super.initState();
    bloc = ForgetPassWordBloc()..getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<ForgetPassWordBloc, ForgetPassWordState>(
        listenWhen: (previous, current) =>
            previous.verifyStatus != current.verifyStatus,
        listener: (context, state) {
          if (state.verifyStatus == VerifyStatus.verifyFailure) {
            CustomSnackBar.showTop(context, '${state.message}', null);
            Future.delayed(const Duration(seconds: 1), () {});
          }
          if (state.verifyStatus == VerifyStatus.wattingCheck &&
              state.sigupType == SigupType.phoneNumber) {
            routeService.pushNamed(Routes.resetPassWordPage,
                arguments: ResetPasswordParams(
                  timeout: state.timeout ?? 0,
                  phoneNumber: state.emailChange,
                ));
          }
          if (state.sigupType == SigupType.emailAddress &&
              state.verifyStatus == VerifyStatus.wattingCheck) {
            _showCustomAlertDialog(context, state.message ?? '');
          }
        },
        child: BlocBuilder<ForgetPassWordBloc, ForgetPassWordState>(
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
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Đặt lại mật khẩu',
                  style: TextStyle(color: colorBlack),
                ),
              ),
              body: LoadingScaffold(
                isLoading: state.isLoading,
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
                          spaceH36,
                          TextFiledInput(
                            validator: _validationEmail,
                            keyboardType: TextInputType.multiline,
                            hintext: 'Nhập email hoặc số điện thoại',
                            onChanged: (email) {
                              bloc.checkTextValidator(email);
                            },
                            isClear: true,
                          ),
                          spaceH20,
                          _button(context, state),
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

  Widget _button(BuildContext context, ForgetPassWordState state) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ResetPassWordPage(
        //               params: ResetPasswordParams(
        //                 phoneNumber: '0967611550',
        //               ),
        //             )));
        FocusScope.of(context).requestFocus(FocusNode());
        final isValidForm = _formKey.currentState?.validate();
        if (isValidForm == true) {
          bloc.onSubmit();
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
            'TIẾP TỤC',
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
            MaterialPageRoute(builder: (builder) => const MainScreenPage()),
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

  void _showCustomAlertDialog(BuildContext context, String meess) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomCupertinoAlertOneButton(
        title: '',
        content: meess,
        onPositiveButtonPressed: () {
          routeService.pushNamed(
            Routes.login,
            arguments: SignInParams(typeDirec: 1),
          );
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
