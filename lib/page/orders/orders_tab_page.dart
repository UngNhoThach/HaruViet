import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/orders/orders_tab_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_tab_bloc.dart';

class OrdersTabPage extends StatefulWidget {
  const OrdersTabPage(
      {super.key,
      required this.onReload,
      required this.locationName,
      required this.isTabDelete});

  final VoidCallback onReload;
  final String locationName;
  final bool isTabDelete;
  @override
  State<OrdersTabPage> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTabPage> {
  late OrdersTabBloc bloc;

  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    bloc = context.read<OrdersTabBloc>()..getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFECECEE),
        body: MultiBlocListener(
          listeners: [
            BlocListener<OrdersTabBloc, OrdersTabState>(
              listener: (context, state) {
                // if (state.countChecked != 0) {
              },
            ),
          ],
          child: BlocBuilder<OrdersTabBloc, OrdersTabState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    spaceH72,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
