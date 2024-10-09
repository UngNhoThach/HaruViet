import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/data/reponsitory/shipment/models/shipment_response/shipment_response.dart';
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

  final TextStyle? styleSubPrice = textTheme.bodyMedium?.copyWith(
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
                      widget.params.selectShipmentFunc!(state.selectedShipment);
                      widget.params.shipmenFunc!(
                          state.shipmentResponse!, state.titleSelected!);
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
                    : Column(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.listShipmentResponse.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      color: colorGray02,
                                      height: 1,
                                      thickness: 10,
                                    ),
                                itemBuilder: (context, index) {
                                  final item =
                                      state.listShipmentResponse[index];
                                  return standardDelivery(
                                      titleDeliver:
                                          state.titleDeliverOption[index],
                                      index: index,
                                      selectedShipment:
                                          state.selectedShipment ?? 0,
                                      shipmentResponse: item);
                                }),
                          ),
                        ],
                      );
              }),
              bottomNavigationBar: BottomBarButton(
                button1: AppSolidButton.medium(
                  context: context,
                  'Xác nhận',
                  textStyle: textTheme.bodyLarge,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    widget.params.selectShipmentFunc!(state.selectedShipment);
                    widget.params.shipmenFunc!(
                        state.shipmentResponse!, state.titleSelected!);
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
      {required int index,
      required int selectedShipment,
      required ShipmentResponse shipmentResponse,
      required String titleDeliver}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        bloc.onSelect(
            titleSelected: titleDeliver,
            selectedShipment: index,
            shipmentResponse: shipmentResponse);
      },
      child: Container(
        decoration: BoxDecoration(
            color: selectedShipment == index
                ? colorRadioSelectedBlueBr.withOpacity(0.3)
                : colorWhite),
        child: Row(
          children: [
            Radio(
              value: selectedShipment,
              groupValue: selectedShipment,
              onChanged: (isChecked) {
                bloc.onSelect(
                    titleSelected: titleDeliver,
                    selectedShipment: isChecked!,
                    shipmentResponse: shipmentResponse);
              },
              activeColor:
                  (selectedShipment == index) ? colorSuccess03 : colorGray03,
            ),
            Expanded(
              child: Column(
                children: [
                  spaceH8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (shipmentResponse.fee?.extFees != null &&
                          shipmentResponse.fee!.extFees!.isNotEmpty) ...[
                        spaceH6,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: shipmentResponse.fee!.extFees!
                              .map(
                                (e) => Text(
                                  "${e.title}  ${e.display ?? '0 đ'}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  //   softWrap: true,
                                  style: styleSubTitle,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                      if (shipmentResponse.fee?.insuranceFee != null) ...[
                        Text(
                            "Phí bảo hiểm ${shipmentResponse.fee?.insuranceFee}",
                            style: styleSubTitle),
                        const Divider()
                      ],
                      Text(
                        titleDeliver,
                        style: styleTitle,
                      ),
                      spaceH4,
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "17 tháng 2 - 2024  |  ",
                              style: styleSubPrice),
                          TextSpan(
                              text: defaultCurrencyVNDFormatter.formatString(
                                  shipmentResponse.fee?.fee.toString() ?? "0"),
                              style: styleSubPrice)
                        ]),
                      ),
                    ],
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
