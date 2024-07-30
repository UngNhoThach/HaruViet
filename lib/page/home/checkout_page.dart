import 'package:haruviet/component/input/text_filed_icon.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/checkout/checkout_bloc.dart';
import 'package:haruviet/page/cart/checkout/checkout_state.dart';
import 'package:haruviet/page/cart/checkout/widgets/checkout_params.dart';
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
  late CheckOutBloc bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FocusNode _focusNodeVoucher = FocusNode();
  final FocusNode _focusNodeNote = FocusNode();

  @override
  void initState() {
    super.initState();
    bloc = CheckOutBloc()..getData(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<CheckOutBloc, CheckOutState>(
        listener: (context, state) {},
        child: GestureDetector(
          onTap: () {
            _focusNodeVoucher.unfocus();
            _focusNodeNote.unfocus();
          },
          child: BlocBuilder<CheckOutBloc, CheckOutState>(
            builder: (context, state) {
              return Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: colorMain,
                  title: const Text(
                    "Xác nhận",
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
                              selectedAddressSection(),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardDelivery(),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardCheckOutMethod(),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardInfoItem(),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardVoucher(),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardBill(),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardNote(),
                              const Divider(
                                color: colorGray02,
                                height: 1,
                                thickness: 10,
                              ),
                              standardFinal(),
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

  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState?.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("images/ic_thank_you.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            // style: CustomTextStyle.textFormFieldMedium.copyWith(
                            //     fontSize: 14, color: Colors.grey.shade800),
                          )
                        ])),
                    SizedBox(
                      height: 24,
                    ),
                    // RaisedButton(
                    //   onPressed: () {},
                    //   padding: EdgeInsets.only(left: 48, right: 48),
                    //   child: Text(
                    //     "Track Order",
                    //     style: CustomTextStyle.textFormFieldMedium
                    //         .copyWith(color: Colors.white),
                    //   ),
                    //   color: Colors.pink,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(24))),
                    // )
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }

  selectedAddressSection() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: colorWhite,
      )),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
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
                    // Text(
                    //   'Số điện thoại: ',
                    //   style: textTheme.bodyMedium
                    //       ?.copyWith(color: colorBlack, fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      '090 9333 9999',
                      style: textTheme.bodyMedium?.copyWith(
                          color: colorBlack, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                spaceH6,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '431, Trần Hưng Đạo, P9, Q1 TPHCM 431, Trần Hưng Đạo, P9, Q1 TPHCM 431, Trần Hưng Đạo, P9, Q1 TPHCM',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorGray04,
                        ),
                      ),
                    ),
                  ],
                ),
                spaceH12,
              ],
            ),
          ),
          spaceW6,
          InkWell(
            onTap: () {
              routeService.pushNamed(
                Routes.addressPage,
              );
            },
            child: const Icon(
              Icons.navigate_next,
              color: colorGray05,
            ),
          )
        ],
      ),
    );
  }

  standardDelivery() {
    return Container(
      decoration: BoxDecoration(color: Colors.tealAccent.withOpacity(0.2)),
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
                      activeColor: Colors.tealAccent.shade400,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Hình thức vận chuyển",
                          style: textTheme.bodyLarge?.copyWith(
                              color: colorBlack, fontWeight: FontWeight.w600),
                        ),
                        spaceH6,
                        Text(
                          "Giao hàng tiêu chuẩn",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorBlack,
                          ),
                        ),
                        spaceH6,
                        Text(
                          "17 tháng 2 - 2024 | Miễn phí giao hàng",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorBlack,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                spaceH20,
              ],
            ),
          ),
          spaceW6,
          InkWell(
            onTap: () {},
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

  standardCheckOutMethod() {
    return Container(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Phương thức thanh toán",
                          style: textTheme.bodyLarge?.copyWith(
                              color: colorBlack, fontWeight: FontWeight.w600),
                        ),
                        spaceH6,
                        Text(
                          "Thanh toán khi nhận hàng (COD)",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorSuccess03,
                          ),
                        )
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
                Routes.paymentMethodPage,
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
  standardNote() {
    return Container(
      decoration: const BoxDecoration(color: colorWhite),
      child: CustomTextInput(
        onChanged: (p0) {},
        maxLines: 3,
        focusNode: _focusNodeNote,
        isNotLabelText: true,
        isNotValidate: true,
        prefixIcon: const Column(
          children: [
            Icon(
              Icons.note_alt_outlined,
              color: colorGray03,
            ),
          ],
        ),
        isCheckPadding: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        hintTextString: 'Nhập ghi chú (Nếu có)',
        inputType: InputType.Default,
        enableBorder: false,
        cornerRadius: 0,
        maxLength: 100,
        textColor: colorBlack,
      ),
    );
  }
// final output

// note
  standardFinal() {
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
                    style: textTheme.bodyMedium?.copyWith(color: colorGray03),
                  ),
                  spaceH8,
                  Text(
                    "Giảm giá",
                    style: textTheme.bodyMedium?.copyWith(color: colorGray03),
                  ),
                  spaceH8,
                  Text(
                    "Phí vận chuyển",
                    style: textTheme.bodyMedium?.copyWith(color: colorGray03),
                  ),
                  spaceH8,
                  Text(
                    "Thành tiền (đã VAT)",
                    style: textTheme.bodyLarge?.copyWith(color: colorBlack),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  spaceH8,
                  Text(
                    "4.967.000 đ",
                    style: textTheme.bodyMedium?.copyWith(color: colorGray03),
                  ),
                  spaceH8,
                  Text(
                    "- 267.000 đ",
                    style: textTheme.bodyMedium?.copyWith(color: colorGray03),
                  ),
                  spaceH8,
                  Text(
                    "Miễn phí",
                    style:
                        textTheme.bodyMedium?.copyWith(color: colorSuccess03),
                  ),
                  spaceH8,
                  Text(
                    "4.700.000 đ",
                    style: textTheme.bodyLarge?.copyWith(
                        color: colorMain, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          spaceH20,
          GestureDetector(
            onTap: () {
              routeService.pushNamed(
                Routes.writeReviewPage,
              );
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

  standardInfoItem() {
    return Container(
      decoration: const BoxDecoration(color: colorWhite),
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
                    "Thông tin đơn hàng",
                    style: textTheme.bodyLarge?.copyWith(
                        color: colorBlack, fontWeight: FontWeight.bold),
                  ),
                  spaceH6,
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.only(top: 16.h, left: 4.w, right: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '20  x',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorGray04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          spaceW6,
                          Text(
                            '900.000 đ',
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorMain,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      spaceH6,
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        'Tủ lạnh Samsung Inverter 599 lít Tủ lạnh Samsung Inverter 599 lít Tủ lạnh Samsung Inverter 599 lít Tủ lạnh Samsung Inverter 599 lít',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: colorSecondary03,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      spaceH6,
                    ],
                  ),
                ),
              ),
              spaceW16,
            ],
          ),
          spaceH20,
        ],
      ),
    );
  }

  checkoutItem() {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding:
              const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return checkoutListItem();
            },
            itemCount: 3,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  checkoutListItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage(
                "images/details_shoes_image.webp",
              ),
              width: 35,
              height: 45,
              fit: BoxFit.fitHeight,
            ),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          ),
          SizedBox(
            width: 8,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "Estimated Delivery : ",
                // style: CustomTextStyle.textFormFieldMedium
                //     .copyWith(fontSize: 12)
              ),
              TextSpan(
                text: "21 Jul 2019 ",
                // style: CustomTextStyle.textFormFieldMedium
                //     .copyWith(fontSize: 12, fontWeight: FontWeight.w600)
              )
            ]),
          )
        ],
      ),
    );
  }

  priceSection() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "PRICE DETAILS",
                // style: CustomTextStyle.textFormFieldMedium.copyWith(
                //     fontSize: 12,
                //     color: Colors.black,
                //     fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              // createPriceItem("Total MRP", getFormattedCurrency(5197),
              //     Colors.grey.shade700),
              // createPriceItem("Bag discount", getFormattedCurrency(3280),
              //     Colors.teal.shade300),
              // createPriceItem(
              //     "Tax", getFormattedCurrency(96), Colors.grey.shade700),
              // createPriceItem("Order Total", getFormattedCurrency(2013),
              //     Colors.grey.shade700),
              // createPriceItem(
              //     "Delievery Charges", "FREE", Colors.teal.shade300),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total",
                    // style: CustomTextStyle.textFormFieldSemiBold
                    //     .copyWith(color: Colors.black, fontSize: 12),
                  ),
                  Text(''
                      // getFormattedCurrency(2013),
                      // style: CustomTextStyle.textFormFieldMedium
                      //     .copyWith(color: Colors.black, fontSize: 12),
                      )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            // style: CustomTextStyle.textFormFieldMedium
            //     .copyWith(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            // style: CustomTextStyle.textFormFieldMedium
            //     .copyWith(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}
