import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:haruviet/component/error/not_found_v2.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/data/reponsitory/shipment/payment_response/data_payment.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/shipment/shipment_bloc.dart';
import 'package:haruviet/page/shipment/shipment_state.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/shipment_params.dart';

class ShipmentPage extends StatefulWidget {
  final ShipmentParams params;
  const ShipmentPage({
    required this.params,
    super.key,
  });

  //     final userInfoLogin = await Preference.getUserInfo();

  @override
  State<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends State<ShipmentPage> {
  // variables and functions
  late ShipmentBloc bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // variables and functions

  final TextStyle? styleTitle = textTheme.bodyLarge
      ?.copyWith(color: colorBlack, fontWeight: FontWeight.bold);

  final TextStyle? styleSubPrice = textTheme.titleMedium?.copyWith(
    color: colorSuccess03,
  );

  final TextStyle styleSubTitle = const TextStyle(
    color: colorGray04,
    fontSize: 13,
  );
  @override
  void initState() {
    super.initState();
    bloc = ShipmentBloc()..getData(params: widget.params);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<ShipmentBloc, ShipmentState>(
        listener: (context, state) {},
        child: BlocBuilder<ShipmentBloc, ShipmentState>(
          builder: (context, state) {
            return Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: colorWhite),
                    onPressed: () {
                      widget.params
                          .selectShipmentFunc!(state.selectedItemShipment);
                      Navigator.of(context).pop();
                    }),
                backgroundColor: Theme.of(context).primaryColor,
                title: const Text(
                  "Phương thức vận chuyển",
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: Builder(builder: (context) {
                return state.isLoading
                    ? const LoadingLogo()
                    : state.listShipmentData == null ||
                            state.listShipmentData!.isEmpty
                        ? const DidntFoundV2()
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.listShipmentData!.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      color: colorGray02,
                                      height: 1,
                                      thickness: 10,
                                    ),
                                itemBuilder: (context, index) {
                                  final item = state.listShipmentData![index];
                                  return standardDelivery(
                                      selectedItemShipment: item,
                                      isSelected: item.key ==
                                          state.selectedItemShipment?.key);
                                }),
                          );
              }),
              bottomNavigationBar: state.listShipmentData == null ||
                      state.listShipmentData!.isEmpty
                  ? null
                  : BottomBarButton(
                      button1: AppSolidButton.medium(
                        context: context,
                        'Xác nhận',
                        textStyle: textTheme.bodyLarge,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          widget.params
                              .selectShipmentFunc!(state.selectedItemShipment);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  standardDelivery(
      {required bool isSelected, required DataPayment selectedItemShipment}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        bloc.onSelect(selectedItemShipment: selectedItemShipment);
      },
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? colorRadioSelectedBlueBr.withOpacity(0.3)
                : colorWhite),
        child: Row(
          children: [
            Radio(
              value: isSelected,
              groupValue: isSelected,
              onChanged: (isChecked) {
                bloc.onSelect(selectedItemShipment: selectedItemShipment);
              },
              activeColor: isSelected ? colorSuccess03 : colorGray03,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  spaceH12,
                  // Text(
                  //   " '0 đ'}",
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: styleSubTitle,
                  // ),
                  //     Text("Phí bảo hiểm ", style: styleSubTitle),
                  Text(
                    selectedItemShipment.title ?? '',
                    style: styleTitle,
                  ),
                  spaceH12,
                  RichText(
                    text: TextSpan(children: [
                      // TextSpan(text: "", style: styleSubPrice),
                      TextSpan(
                          text: defaultCurrencyVNDFormatter.formatString(
                              selectedItemShipment.value.toString()),
                          style: styleSubPrice)
                    ]),
                  ),
                  spaceH16,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
