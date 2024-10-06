import 'package:haruviet/component/input/text_filed_icon.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/add_address/add_address/widgets/address_params.dart';
import 'package:haruviet/page/cart/checkout/checkout_bloc.dart';
import 'package:haruviet/page/cart/checkout/checkout_state.dart';
import 'package:haruviet/page/cart/checkout/widgets/checkout_params.dart';
import 'package:haruviet/page/cart/payment_method/widgets/payment_method_params.dart';
import 'package:haruviet/page/shipment/widgets/shipment_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOutPage extends StatefulWidget {
  final CheckoutParams params;
  const CheckOutPage({
    super.key,
    required this.params,
  });

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  // variables and functions
  late String domain;
  final _formKey = GlobalKey<FormState>();

  late CheckOutBloc bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FocusNode _focusNodeVoucher = FocusNode();
  final FocusNode _focusNodeNote = FocusNode();

  final TextStyle styleSubTitle = const TextStyle(
    color: colorGray04,
    fontSize: 13,
  );
  final TextStyle? styleSubPrice = textTheme.bodyMedium?.copyWith(
    color: colorSuccess03,
  );

  final TextStyle? styleTitle = textTheme.bodyLarge
      ?.copyWith(color: colorBlack, fontWeight: FontWeight.bold);

  //

  @override
  void initState() {
    super.initState();
    domain = context.read<UserBloc>().state.subDomain ?? '';

    bloc = CheckOutBloc(context)..getData(widget.params);
  }

  @override
  void dispose() {
    _focusNodeNote.dispose();
    _focusNodeVoucher.dispose();
    super.dispose();
  }

  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<CheckOutBloc, CheckOutState>(
        listener: (context, state) {},
        child: GestureDetector(
          onTap: () {
            _hideKeyboard();
          },
          child: BlocBuilder<CheckOutBloc, CheckOutState>(
            builder: (context, state) {
              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  backgroundColor: colorMain,
                  title: const Text(
                    "Thanh toán",
                    style: TextStyle(
                        color: colorWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: Builder(builder: (context) {
                  return state.isLoading
                      ? const LoadingLogo()
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              standardCheckOutMethod(
                                  indexShippingMethod:
                                      state.indexShippingMethod,
                                  valueShippingMethod:
                                      state.valueShippingMethod!),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              _selectedAddressWidget(
                                  idAddressShipping: state.idAddressShipping!,
                                  addressShipping: state.addressShipping!),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardDelivery(
                                state: state,
                              ),

                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              renderBody(context,
                                  productList: state.productsList),
                              // _checkoutWidget(context,
                              //     productList: state.productsList),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              _standardNote(context),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardFinal(
                                  total: state.totalPrice ?? 0,
                                  fee: state.shipmentResponse?.fee?.fee ?? 0),
                              spaceH100,
                            ],
                          ),
                        );
                }),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _selectedAddressWidget({
    required DataListAddress addressShipping,
    required String idAddressShipping,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        routeService.pushNamed(Routes.addressPage,
            arguments: AddressParams(
              isShipping: true,
              idAddressShipping: idAddressShipping,
              returnAddress: (addressShipping) {
                bloc.onChangeAddressShipping(
                  addressShipping: addressShipping!,
                );
              },
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: colorWhite,
        )),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  spaceH6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Địa chỉ (mặc định)",
                        style: textTheme.bodyLarge?.copyWith(
                            color: colorBlack, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        child: const Text(
                          "Nhà riêng",
                          style: TextStyle(fontSize: 12, color: colorBlack),
                        ),
                      )
                    ],
                  ),
                  spaceH6,
                  Row(
                    children: [
                      Text(addressShipping.phone ?? '', style: styleSubPrice),
                    ],
                  ),
                  spaceH6,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            '${addressShipping.address3 ?? ''}, ${addressShipping.address2 ?? ''},${addressShipping.address1 ?? ''}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: styleSubPrice),
                      ),
                    ],
                  ),
                  spaceH12,
                ],
              ),
            ),
            spaceW6,
            const Icon(
              Icons.navigate_next,
              color: colorGray05,
            ),
          ],
        ),
      ),
    );
  }

  standardDelivery({required CheckOutState state}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        routeService.pushNamed(Routes.shipmentPage,
            arguments: ShipmentParams(
              selectedShipment: state.selectedShipment,
              selectShipmentFunc: (selectedShipment) {
                bloc.onChangeSelectedShipment(
                    selectedShipment: selectedShipment!);
              },
              titleSelected: state.titleSelected ?? '',
              weight: widget.params.weight,
              shippingAddress: state.shippingAddress,
              totalPrice: state.totalPrice ?? 0,
              shipmentResponse: state.shipmentResponse!,
              shipmenFunc: (shipmentResponse, titleSelected) {
                bloc.onChangeShipmentMethod(
                    titleSelected: titleSelected,
                    shipmentResponse: shipmentResponse!);
              },
            ));
      },
      child: Container(
        decoration:
            BoxDecoration(color: colorRadioSelectedBlueBr.withOpacity(0.3)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: 1,
                        onChanged: (isChecked) {},
                        activeColor: colorSuccess03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Phương thức vận chuyển nhấn để chọn",
                              style: styleSubTitle),
                          spaceH6,
                          Text(state.titleSelected ?? '', style: styleTitle),
                          spaceH6,
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  //   text: "17 tháng 2 - 2024  |  ",
                                  style: styleSubPrice),
                              TextSpan(
                                  text:
                                      defaultCurrencyVNDFormatter.formatString(
                                          state.shipmentResponse?.fee?.fee
                                                  .toString() ??
                                              "0"),
                                  style: styleSubPrice)
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  spaceH20,
                ],
              ),
            ),
            spaceW6,
            const Icon(
              Icons.navigate_next,
              color: colorGray05,
            ),
            spaceW16,
          ],
        ),
      ),
    );
  }

  standardCheckOutMethod(
      {required String valueShippingMethod, required int indexShippingMethod}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        routeService.pushNamed(Routes.paymentMethodPage,
            arguments: PaymentMethodParams(
              indexShippingMethod: indexShippingMethod,
              shippingMethodFuc: (valueShippingMethod, indexShippingMethod) {
                bloc.onChangeValueShippingMethod(
                    indexShippingMethod: indexShippingMethod!,
                    valueShippingMethod: valueShippingMethod!);
              },
            ));
      },
      child: Container(
        decoration: const BoxDecoration(color: colorWhite),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      spaceW16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Phương thức thanh toán", style: styleTitle),
                            spaceH6,
                            Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              valueShippingMethod,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorSuccess03,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  spaceH24,
                ],
              ),
            ),
            spaceW6,
            const Icon(
              Icons.navigate_next,
              color: colorGray05,
            ),
            spaceW16,
          ],
        ),
      ),
    );
  }

// Bill

  standardBill() {
    return Container(
      decoration: const BoxDecoration(color: colorWhite),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                spaceH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    spaceW16,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Thông tin xuất hoá đơn",
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge?.copyWith(
                              color: colorBlack, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                spaceH24,
              ],
            ),
          ),
          spaceW6,
          InkWell(
            onTap: () {
              routeService.pushNamed(
                Routes.billInfoPage,
              );
            },
            child: const Icon(
              Icons.navigate_next,
              color: colorGray05,
            ),
          ),
          spaceW16,
        ],
      ),
    );
  }

// Voucher
  standardVoucher() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: colorWhite),
            //
            child: CustomTextInput(
              onChanged: (p0) {},
              focusNode: _focusNodeVoucher,
              isNotLabelText: true,
              isNotValidate: true,
              isCheckPadding: true,
              prefixIcon: const Icon(
                Icons.discount,
                color: colorGray03,
              ),
              padding: const EdgeInsets.only(
                  bottom: 12, top: 8, left: 16, right: 16),
              hintTextString: 'Nhập mã giảm giá/ đổi quà',
              inputType: InputType.Default,
              enableBorder: false,
              cornerRadius: 0,
              maxLength: 24,
              textColor: colorBlack,
            ),
          ),
        ),
        spaceW6,
        InkWell(
          onTap: () {
            routeService.pushNamed(
              Routes.voucherPage,
            );
          },
          child: const Icon(
            Icons.navigate_next,
            color: colorGray05,
          ),
        ),
        spaceW16,
      ],
    );
  }

// note
  Widget _standardNote(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: colorWhite),
      child: TextFormField(
        minLines: 4, // Set this
        maxLines: 100, // and this
        key: _formKey,
        enabled: true,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(16),
            hintText: "Để lại ghi chú (nếu có)"),
        onChanged: (value) {
          // bloc.onChangeComment(comment: value);
        },
        onFieldSubmitted: (value) {
          //  bloc.onChangeComment(comment: value);
        },
      ),
    );
  }
// final output

// note
  standardFinal({required int total, required int fee}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: const BoxDecoration(color: colorWhite),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  spaceH8,
                  Text(
                    "Tạm tính",
                    style: styleSubTitle,
                  ),
                  spaceH8,
                  Text(
                    "Giảm giá",
                    style: styleSubTitle,
                  ),
                  spaceH8,
                  Text(
                    "Phí vận chuyển",
                    style: styleSubTitle,
                  ),
                  spaceH8,
                  Text("Thành tiền (đã VAT)", style: styleTitle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  spaceH8,
                  Text(
                      defaultCurrencyVNDFormatter.formatString(
                          (total + widget.params.discountOrder).toString()),
                      style: styleSubPrice),
                  spaceH8,
                  Text(
                      defaultCurrencyVNDFormatter
                          .formatString(widget.params.discountOrder.toString()),
                      style: styleSubPrice),
                  spaceH8,
                  Text(defaultCurrencyVNDFormatter.formatString(fee.toString()),
                      style: styleSubPrice),
                  spaceH8,
                  Text(
                    defaultCurrencyVNDFormatter
                        .formatString((total + fee).toString()),
                    style: textTheme.titleLarge?.copyWith(
                        color: colorMain, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          spaceH20,
          GestureDetector(
            onTap: () {
              CustomSnackBar.showTop(context, 'Chức năng đang được phát triển');
            },
            child: Container(
              height: 38.h,
              decoration: BoxDecoration(
                color: colorMain,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorGray02),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đặt hàng',
                    style: textTheme.bodyLarge?.copyWith(
                        color: colorWhite, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderBody(
    BuildContext context, {
    required List<CartModelProduct> productList,
  }) {
    return Container(
        color: const Color(0xFFFFFFFF),
        child: Column(
            children: List.generate(productList.length * 2 - 1, (index) {
          if (!index.isEven) {
            return Container(
              color: colorGray02,
              height: 1,
              width: double.infinity,
              child: const SizedBox(),
            );
          } else {
            return _itemProductRender(context, item: productList[index ~/ 2]);
          }
        })));
  }

  Widget _itemProductRender(
    BuildContext context, {
    required CartModelProduct item,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      height: 82.h,
      width: double.infinity,
      child: Column(children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: double.infinity,
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 56.w,
                  height: 56.h,
                  child: Image.network(
                    '$domain${item.image}',
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  item.descriptions.name ?? '',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            Text("Số lượng: ${item.totalQuantity}",
                                style: styleSubTitle),
                            spaceH4,
                            Text(
                                defaultCurrencyVNDFormatter
                                    .formatString(item.price.price.toString()),
                                style: styleSubTitle),
                          ]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            defaultCurrencyVNDFormatter.formatString(
                                (item.price.price! * item.totalQuantity)
                                    .toString()),
                            style: styleSubPrice
                            //
                            ),
                        if (item.price.discountDetail != 0) ...[
                          spaceH4,
                          Text(
                            '- ${defaultCurrencyVNDFormatter.formatString((item.price.discountDetail).toString())}',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorGray03,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
