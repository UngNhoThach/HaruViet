import 'package:haruviet/component/popup/alert/alert_one_button.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/helper/base_status_response.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/phone_authen/phone_authen_bloc.dart';
import 'package:haruviet/page/account/phone_authen/phone_authen_state.dart';
import 'package:haruviet/page/account/phone_authen/widgets/phone_authen_params.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/main_screen/main_screen_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneAuthPage extends StatefulWidget {
  final PhoneAuthParams params;
  const PhoneAuthPage({super.key, required this.params});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  // variables and functions
  late PhoneAuthBloc bloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc = PhoneAuthBloc()..getData(widget.params);
  }

  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<PhoneAuthBloc, PhoneAuthState>(
        listenWhen: (previous, current) =>
            previous.isSubmitSuccess != current.isSubmitSuccess &&
                current.isSubmitSuccess == true ||
            previous.isSubmitSuccessUpdate != current.isSubmitSuccessUpdate &&
                current.isSubmitSuccessUpdate == true ||
            previous.baseStatusResponse != current.baseStatusResponse,
        listener: (context, state) {
          // if (state.baseStatusResponse == BaseStatusResponse.failure) {
          //   CustomSnackBar.showTop(context, '${state.message}');
          //   // Future.delayed(const Duration(seconds: 1), () {});
          // }
          if (state.isSubmitSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreenPage()),
                (route) => false);
          }
          // if (state.isSubmitSuccessUpdate) {
          //   _showCustomAlertDialog(context, state.message ?? '');
          // }
        },
        child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: colorTransparent,
                centerTitle: true,
                title: const Text(
                  'Xác thực tài khoản',
                  style: TextStyle(color: colorBlack),
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   width: MediaQuery.of(context).size.width - 30,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Container(
                      //           height: 1,
                      //           color: colorGray03,
                      //           margin:
                      //               const EdgeInsets.symmetric(horizontal: 12),
                      //         ),
                      //       ),
                      //       Text(
                      //         "Điền mã OTP",
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .titleMedium
                      //             ?.copyWith(
                      //                 color: colorBlack,
                      //                 fontWeight: FontWeight.w500),
                      //       ),
                      //       Expanded(
                      //         child: Container(
                      //           height: 1,
                      //           color: colorGray03,
                      //           margin:
                      //               const EdgeInsets.symmetric(horizontal: 12),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      spaceH30,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: PinFieldAutoFill(
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
                      ),
                      spaceH20,
                      ritchTextField(context, state),
                      spaceH30,
                      buttonField(state),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget otpField() {
    return Container(
      child: OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width - 32,
        fieldWidth: 58,
        otpFieldStyle: OtpFieldStyle(
          backgroundColor: colorBlueGray01,
        ),
        style: const TextStyle(fontSize: 30, color: colorBlack),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        // fieldStyle: FieldStyle.underline,
        onChanged: (value) {
          bloc.onChangeCodeVerification(value);
        },
        onCompleted: (pin) {},
      ),
    );
  }

  Widget ritchTextField(
    BuildContext context,
    PhoneAuthState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          spaceH8,
          Row(
            children: [
              TweenAnimationBuilder<Duration>(
                  duration: Duration(minutes: state.timeout ?? 0),
                  tween: Tween(
                      begin: Duration(minutes: state.timeout ?? 0),
                      end: Duration.zero),
                  onEnd: () {
                    bloc.onChangeTimeUp(true);
                  },
                  builder:
                      (BuildContext context, Duration value, Widget? child) {
                    final minutes = value.inMinutes;
                    final seconds =
                        (value.inSeconds % 60).toString().padLeft(2, '0');

                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          state.isTimeUp ? '0:00' : '$minutes:$seconds',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
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
                    text:
                        "Chúng tôi đã gửi mã Chúng tôi đã gửi mã xác thực qua",
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
                        bloc.onSignupReplay();
                      },
                      child: Text(
                        'gửi lại',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: colorPrimary,
                                ),
                      ),
                    )
                  ],
                )
              : space0,
        ],
      ),
    );
  }

  Widget buttonField(PhoneAuthState state) {
    return InkWell(
      onTap: () {
        if (state.codeVerification == null ||
            state.codeVerification.toString().length != 6) {
          CustomSnackBar.showTop(context, 'Vui lòng điền đúng 6 số OTP');
        } else {
          // if (widget.params.isUpdatePassWord) {
          //   bloc.onSubmitUpdatePassWord();
          // } else {
          bloc.onSubmit();
          // }
        }
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
            color: colorPrimary, borderRadius: BorderRadius.circular(16)),
        child: const Center(
          child: Text(
            "Tiếp tục",
            style: TextStyle(
              fontSize: 16,
              color: colorWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
