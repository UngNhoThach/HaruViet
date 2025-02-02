import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:haruviet/component/error/not_found_v2.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/component/radio_button/radio_button.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/payment_method/payment_method_state.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';

import 'payment_method_bloc.dart';
import 'widgets/payment_method_params.dart';

class PaymentMethodPage extends StatefulWidget {
  final PaymentMethodParams params;

  const PaymentMethodPage({
    super.key,
    required this.params,
  });

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  // variables and functions
  late PaymentMethodBloc bloc;
  var currentIndexRadio = 1;

  @override
  void initState() {
    super.initState();
    bloc = PaymentMethodBloc()..getData(params: widget.params);
  }

  List<int> counterList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<PaymentMethodBloc, PaymentMethodState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        listener: (context, state) {
          if (state.isLoading) {
            showPopupLoading(context, text: 'Đang tải...');
          } else {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: colorWhite),
                    onPressed: () {
                      widget.params.shippingMethodFuc!(
                          state.valueShipping, state.keyPaymentMethod);
                      Navigator.of(context).pop();
                    }),
                centerTitle: true,
                title: const Text('Phương thức thanh toán'),
              ),
              body: (state.dataPayment == null || state.dataPayment!.isEmpty)
                  ? const DidntFoundV2()
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spaceH8,
                            RadioListSelect(
                              itemsTypeString: [],
                              itemsTypeDataPayment: state.dataPayment!,
                              currentIndex: state.indexShippingMethod,
                              onSelectedIndex: (index) {
                                // onselected types of payment
                                bloc.onChangeShippingMethod(
                                    indexShippingMethod: index!,
                                    keyPaymentMethod:
                                        state.dataPayment![index].key ?? "",
                                    valueShipping:
                                        state.dataPayment![index].title ?? "");
                              },
                            ),
                            spaceH72,
                          ],
                        ),
                      ),
                    ),
              bottomNavigationBar: BottomBarButton(
                button1: AppSolidButton.medium(
                  context: context,
                  'Xác nhận',
                  textStyle: textTheme.bodyLarge,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    widget.params.shippingMethodFuc!(
                        state.valueShipping, state.keyPaymentMethod);
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
}
