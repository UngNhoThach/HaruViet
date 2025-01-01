import 'package:haruviet/component/popup/alert/alert_one_button.dart';
import 'package:haruviet/component/input/password_input.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/helper/base_status_response.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/reset_password/widgets/reset_password_params.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/main_screen/main_screen_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'reset_password_bloc.dart';
import 'reset_password_state.dart';

class ResetPassWordPage extends StatefulWidget {
  final ResetPasswordParams params;
  const ResetPassWordPage({super.key, required this.params});
  @override
  State<ResetPassWordPage> createState() => _ResetPassWordPageState();
}

class _ResetPassWordPageState extends State<ResetPassWordPage> {
  // variables and functions
  late ResetPassWordBloc bloc;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode;

  @override
  void initState() {
    super.initState();
    bloc = ResetPassWordBloc(widget.params)..getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<ResetPassWordBloc, ResetPassWordState>(
        listenWhen: (previous, current) =>
            previous.isSubmitSuccessUpdate != current.isSubmitSuccessUpdate &&
                current.isSubmitSuccessUpdate == true ||
            previous.baseStatusResponse != current.baseStatusResponse,
        listener: (context, state) {
          if (state.baseStatusResponse == BaseStatusResponse.failure) {
            CustomSnackBar.showTop(context, '${state.message}', null);
            // Future.delayed(const Duration(seconds: 1), () {});
          }
          if (state.isSubmitSuccessUpdate) {
            _showCustomAlertDialog(context, state.message ?? '');
          }
        },
        child: BlocBuilder<ResetPassWordBloc, ResetPassWordState>(
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
                backgroundColor: colorTransparent,
                title: const Text(
                  'Đặt lại mật khẩu',
                  style: TextStyle(color: colorBlack),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: autovalidateMode,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        spaceH36,
                        PasswordInputV2(
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "Mật khẩu không được để trống";
                            } else if (password.length < 6) {
                              return "Mật khẩu phải có ít nhất 6 ký tự";
                            }
                            return null;
                          },
                          hintText: 'Mật khẩu mới',
                          onChanged: (password) {
                            bloc.onChangePassword(password);
                          },
                          isClear: true,
                        ),
                        spaceH12,
                        PasswordInputV2(
                          validator: (rePassword) {
                            final password = state.password;
                            if (rePassword != password) {
                              return "Mật khẩu không trùng khớp";
                            }
                            return null;
                          },
                          hintText: 'Nhập lại mật khẩu mới',
                          onChanged: (rePassword) {
                            bloc.onChangeRePassword(rePassword);
                          },
                          isClear: true,
                        ),
                        spaceH32,
                        Row(
                          children: [
                            Text(
                              "Nhập mã xác thực",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: colorBlack,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        spaceH16,
                        PinFieldAutoFill(
                          codeLength: 6,
                          keyboardType: TextInputType.number,
                          decoration: BoxLooseDecoration(
                            gapSpace: 6.w,
                            strokeColorBuilder:
                                FixedColorBuilder(colorBlack.withOpacity(0.3)),
                            // lineStrokeCap: StrokeCap.butt,
                            textStyle:
                                TextStyle(fontSize: 24.r, color: colorBlack),
                          ),
                          currentCode: state.codeVerification == null
                              ? ''
                              : state.codeVerification.toString(),
                          onCodeSubmitted: (code) {},
                          onCodeChanged: (code) {
                            bloc.onChangeCodeVerification(code);
                            if (code!.length == 6) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          },
                        ),
                        spaceH16,
                        ritchTextField(context, state),
                        spaceH32,
                        _button(context, state),
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

  Widget ritchTextField(
    BuildContext context,
    ResetPassWordState state,
  ) {
    return Column(
      children: [
        Row(
          children: [
            TweenAnimationBuilder<Duration>(
                duration: Duration(minutes: state.timeout ?? 0),
                tween: Tween(
                    begin: Duration(minutes: state.timeout ?? 0),
                    end: Duration.zero),
                onEnd: () {
                  //    bloc.onChangeTimeUp(true);
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  final minutes = value.inMinutes;
                  final seconds =
                      (value.inSeconds % 60).toString().padLeft(2, '0');

                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        state.isTimeUp ? '0:00' : '$minutes:$seconds',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: colorPrimary,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8),
                      ));
                }),
          ],
        ),
        spaceH16,
        Wrap(
          children: [
            RichText(
              maxLines: 2,
              text: TextSpan(children: [
                TextSpan(
                  text: "Chúng tôi đã gửi mã Chúng tôi đã gửi mã xác thực qua",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 0.8,
                        color: colorBlack,
                      ),
                ),
                TextSpan(
                  text: " ${state.nameGetOTP} ",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorPrimary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                ),
                TextSpan(
                  text: "vui lòng kiểm tra",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorBlack,
                        letterSpacing: 0.8,
                      ),
                ),
              ]),
            ),
          ],
        ),
        spaceH16,
        state.isTimeUp
            ? Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // bloc.onSignupReplay();
                    },
                    child: Text(
                      'gửi lại',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colorPrimary,
                          ),
                    ),
                  )
                ],
              )
            : space0,
      ],
    );
  }

  Widget _button(BuildContext context, ResetPassWordState state) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        final isValidForm = _formKey.currentState?.validate();
        if (isValidForm == true) {
          if (state.codeVerification == null ||
              state.codeVerification.toString().length != 6) {
            CustomSnackBar.showTop(context, 'Vui lòng điền mã OTP', null);
          } else {
            bloc.onSubmitUpdatePassWord();
          }
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
}
