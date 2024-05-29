import 'package:eco_app/component/loading/loading.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/add_address/add_address/widgets/add_address_params.dart';
import 'package:eco_app/page/add_address/address_bloc.dart';
import 'package:eco_app/page/add_address/address_state.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressPage extends StatefulWidget {
  // final CheckoutParams params;
  const AddressPage({
    super.key,
    // required this.params,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // variables and functions
  late AddressBloc bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FocusNode _focusNodeVoucher = FocusNode();
  final FocusNode _focusNodeNote = FocusNode();
  // variables and functions

  @override
  void initState() {
    super.initState();
    bloc = AddressBloc()..getData();
  }

  final List<bool> values = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<AddressBloc, AddressState>(
        listener: (context, state) {},
        child: GestureDetector(
          onTap: () {
            _focusNodeVoucher.unfocus();
            _focusNodeNote.unfocus();
          },
          child: BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              return Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: colorMain,
                  title: const Text(
                    "Địa chỉ của tôi",
                    style: TextStyle(
                        color: colorWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: Builder(builder: (context) {
                  return state.isLoading
                      ? const LoadingLogo()
                      : Column(
                          children: [
                            Expanded(
                              flex: 9,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: state.listAddresses.length,
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                          color: colorGray02,
                                          height: 1,
                                          thickness: 10,
                                        ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          routeService.pushNamed(
                                              Routes.addnewaddressPage,
                                              arguments: AddNewAddressParams(
                                                dataListAddress:
                                                    state.listAddresses[index],
                                                isUpdate: true,
                                                onReload: () {
                                                  bloc.getData();
                                                },
                                              ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colorWhite,
                                            border:
                                                Border.all(color: colorWhite),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              spaceW6,
                                              // Checkbox(
                                              //   value: state
                                              //       .listAddresses[index]
                                              //       .isDefault,
                                              //   onChanged: (bool? newValue) {
                                              //     bloc.onChaneDefalutLocation(
                                              //         index: index,
                                              //         value: newValue!);
                                              //     // if (newValue != null) {
                                              //     //   setState(() {
                                              //     //     // for (int i = 0;
                                              //     //     //     i <
                                              //     //     //         state.listAddresses
                                              //     //     //             .length;
                                              //     //     //     i++) {
                                              //     //     //   if (i == index) {
                                              //     //     //     values[i] = newValue;
                                              //     //     //   } else {
                                              //     //     //     valuesi] = false;
                                              //     //     //   }
                                              //     //     // }
                                              //     //   });
                                              //     // }
                                              //   },
                                              // ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    spaceH6,
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          state.addressDefaultId ==
                                                                  state
                                                                      .listAddresses[
                                                                          index]
                                                                      .id
                                                              ? "Địa chỉ (mặc định)"
                                                              : "Địa chỉ",
                                                          style: textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                            color: colorBlack,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   padding:
                                                        //       const EdgeInsets
                                                        //           .symmetric(
                                                        //           horizontal: 12,
                                                        //           vertical: 6),
                                                        //   decoration:
                                                        //       BoxDecoration(
                                                        //     shape: BoxShape
                                                        //         .rectangle,
                                                        //     color: Colors
                                                        //         .grey.shade300,
                                                        //     borderRadius:
                                                        //         const BorderRadius
                                                        //             .all(
                                                        //       Radius.circular(16),
                                                        //     ),
                                                        //   ),
                                                        //   child: const Text(
                                                        //     "Nhà riêng",
                                                        //     style: TextStyle(
                                                        //         fontSize: 12,
                                                        //         color:
                                                        //             colorBlack),
                                                        //   ),
                                                        // )
                                                      ],
                                                    ),
                                                    spaceH6,
                                                    Row(
                                                      children: [
                                                        Text(
                                                          state
                                                                  .listAddresses[
                                                                      index]
                                                                  .phone ??
                                                              ' ',
                                                          style: textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color: colorBlack,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    spaceH6,
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            '${state.listAddresses[index].address3 ?? ''}, ${state.listAddresses[index].address2 ?? ''},${state.listAddresses[index].address1 ?? ''}',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                              color:
                                                                  colorGray04,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    spaceH12,
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  routeService
                                      .pushNamed(Routes.addnewaddressPage,
                                          arguments: AddNewAddressParams(
                                    onReload: () {
                                      bloc.getData();
                                    },
                                  ));
                                },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          color: colorWhite,
                                        ),
                                        spaceW4,
                                        Text(
                                          'Thêm địa chỉ',
                                          style: textTheme.bodySmall?.copyWith(
                                            color: colorWhite,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        spaceW4,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
