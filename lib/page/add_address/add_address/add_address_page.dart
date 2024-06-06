import 'package:eco_app/component/button/bottom_bar_button.dart';
import 'package:eco_app/component/button/solid_button.dart';
import 'package:eco_app/component/dropdown/form_address_input.dart';
import 'package:eco_app/component/input/textfiled_input.dart';
import 'package:eco_app/component/loading/loading.dart';
import 'package:eco_app/component/snackbar/snackbar_bottom.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/add_address/add_address/add_address_bloc.dart';
import 'package:eco_app/page/add_address/add_address/add_address_state.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/add_address_params.dart';

class AddNewAddressPage extends StatefulWidget {
  final AddNewAddressParams params;
  const AddNewAddressPage({
    super.key,
    required this.params,
  });

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  // variables and functions
  late AddNewAddressBloc bloc;
  AutovalidateMode? autovalidateMode;
  final _formkey = GlobalKey<FormState>();

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'không hợp lệ';
    }
    return null;
  }

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
    super.initState();
    bloc = AddNewAddressBloc()..getData(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<AddNewAddressBloc, AddNewAddressState>(
        listener: (context, state) {},
        child: BlocListener<AddNewAddressBloc, AddNewAddressState>(
          listenWhen: (previous, current) =>
              (previous.isSubmitSuccess != current.isSubmitSuccess &&
                  current.isSubmitSuccess == true),
          listener: (context, state) {
            CustomSnackBar.showTop(context, state.message ?? '');
            widget.params.onReload.call();
            context.justBack();
          },
          child: BlocBuilder<AddNewAddressBloc, AddNewAddressState>(
            builder: (context, state) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: colorMain,
                  title: Text(
                    widget.params.isUpdate
                        ? "Cập nhật địa chỉ"
                        : "Thêm địa chỉ",
                    style: const TextStyle(
                        color: colorWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: Builder(builder: (context) {
                  return state.isLoading
                      ? const LoadingLogo()
                      : SingleChildScrollView(
                          child: Form(
                            autovalidateMode: autovalidateMode,
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: colorGray01,
                                  padding: EdgeInsets.all(16.r),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Liên hệ',
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: colorMain,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: colorGray03,
                                ),
                                TextFiledInputText(
                                  isBorder: false,
                                  initialText: state.name,
                                  validator: _validator,
                                  keyboardType: TextInputType.name,
                                  icon: const Icon(
                                    Icons.person,
                                  ),
                                  hintext: 'Họ tên người nhận',
                                  onChanged: (name) {
                                    bloc.onChangeName(name);
                                  },
                                ),
                                const Divider(
                                  color: colorGray03,
                                ),
                                TextFiledInputText(
                                  isBorder: false,
                                  initialText: state.phone,
                                  validator: _validatorPhone,
                                  keyboardType: TextInputType.name,
                                  icon: const Icon(
                                    Icons.phone,
                                  ),
                                  hintext: 'Số điện thoại',
                                  onChanged: (phoneNumber) {
                                    bloc.onChangePhoneNumber(phoneNumber);
                                  },
                                ),
                                const Divider(
                                  color: colorGray03,
                                ),
                                Container(
                                  color: colorGray01,
                                  padding: EdgeInsets.all(16.r),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Địa chỉ nhận hàng',
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: colorMain,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: colorGray03,
                                ),
                                FormAddressInput(
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 8, top: 8, right: 0, left: 0),
                                  widget: Padding(
                                    padding: EdgeInsets.only(
                                        left: (state.address ?? '').isNotEmpty
                                            ? 0
                                            : 12),
                                    child: (state.address ?? '').isNotEmpty
                                        ? null
                                        : const Icon(
                                            Icons.location_on,
                                            color: colorGray03,
                                            size: 24,
                                          ),
                                  ),
                                  isBorder: false,
                                  key: ObjectKey(state.address1),
                                  isDisplayTitle: false,
                                  title: 'Địa chỉ',
                                  initialText: state.address1 == null
                                      ? null
                                      : '${state.address3 ?? ''}, ${state.address2 ?? ''}, ${state.address1 ?? ''}',
                                  onChanged: (value) {
                                    bloc.onChangeTemporaryResidenceAddressUser(
                                        temporaryResidenceAddress: value);
                                  },
                                ),
                                const Divider(
                                  color: colorGray03,
                                ),
                                Container(
                                  color: colorGray01,
                                  padding: EdgeInsets.all(16.r),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Cài đặt',
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: colorMain,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: colorGray03,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    spaceH8,
                                    Row(
                                      children: [
                                        spaceW16,
                                        Text(
                                          'Loại địa chỉ',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: context.appColorScheme
                                                .colorExtendedTextBodyMedium,
                                            height: 1.4,
                                            wordSpacing: 1.2,
                                          ),
                                        ),
                                        spaceW30,
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: InkWell(
                                                  onTap: () {
                                                    bloc.onChangeLocationDefault(
                                                        1);
                                                  },
                                                  child: Container(
                                                    height: 36,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          state.isLocationDefault ==
                                                                  1
                                                              ? colorPrimary
                                                              : null,
                                                      border: Border.all(
                                                          color: colorGray02),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .home_repair_service_sharp,
                                                          color:
                                                              state.isLocationDefault ==
                                                                      1
                                                                  ? colorWhite
                                                                  : colorBlack,
                                                        ),
                                                        spaceW16,
                                                        Text('Công ty',
                                                            style: TextStyle(
                                                                color: state.isLocationDefault ==
                                                                        1
                                                                    ? colorWhite
                                                                    : colorBlack)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: InkWell(
                                                  onTap: () {
                                                    bloc.onChangeLocationDefault(
                                                        2);
                                                  },
                                                  child: Container(
                                                    height: 36,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          state.isLocationDefault ==
                                                                  2
                                                              ? colorPrimary
                                                              : null,
                                                      border: Border.all(
                                                          color: colorGray02),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.home,
                                                          color:
                                                              state.isLocationDefault ==
                                                                      2
                                                                  ? colorWhite
                                                                  : colorBlack,
                                                        ),
                                                        spaceW16,
                                                        Text('Nhà',
                                                            style: TextStyle(
                                                                color: state.isLocationDefault ==
                                                                        2
                                                                    ? colorWhite
                                                                    : colorBlack)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        spaceW16,
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: state.textBtnswitchState
                                                ? () {}
                                                : null,
                                            child: Text(
                                              overflow: TextOverflow.clip,
                                              maxLines: null,
                                              'Đặt làm địa chỉ mặc định',
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: state.textBtnswitchState
                                                    ? colorPrimary
                                                    : context.appColorScheme
                                                        .colorExtendedTextBodyMedium,
                                                height: 1.4,
                                                wordSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                          Switch(
                                            value: state.textBtnswitchState,
                                            onChanged: (newState) =>
                                                bloc.onChangeBtnswitchState(
                                                    newState),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: colorGray03,
                                ),
                              ],
                            ),
                          ),
                        );
                }),
                bottomNavigationBar: BottomBarButton(
                  button1: AppSolidButton.medium(
                    widget.params.isUpdate ? 'Cập nhật' : 'Thêm',
                    textStyle: textTheme.bodyLarge,
                    color: widget.params.isUpdate ? colorPrimary : colorMain,
                    onPressed: () {
                      final isValidForm = _formkey.currentState?.validate();
                      if (isValidForm == true) {
                        widget.params.isUpdate
                            ? bloc.onSubmit(true)
                            : bloc.onSubmit(false);
                      } else {
                        autovalidateMode = AutovalidateMode.onUserInteraction;
                      }
                    },
                  ),
                  button2: widget.params.isUpdate
                      ? AppSolidButton.medium(
                          'Xoá',
                          textStyle: textTheme.bodyLarge,
                          color: colorMain,
                          onPressed: () {
                            showConfirmActionSheet(
                              context,
                              message: 'Anh/chị có chắc muốn xoá?',
                              confirmButtonLabel: 'Đồng ý',
                              onConfirm: () {
                                bloc.onDelete();
                              },
                            );
                          },
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
