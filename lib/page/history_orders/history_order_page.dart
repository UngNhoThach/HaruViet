import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/page/history_orders/tab/widgets/history_order_tab_params.dart';
import 'package:haruviet/page/history_orders/widget/history_order_params.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:badges/badges.dart' as badges;

import 'history_order_bloc.dart';
import 'history_order_state.dart';
import 'tab/history_order_tab.dart';
import 'tab/history_order_tab_bloc.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({
    super.key,
    required this.params,
  });
  final HistoryOrderParams params;

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage>
    with TickerProviderStateMixin {
  late HistoryOrderBloc bloc;
  late TabController _tabController;
  late PageController _pageController;

  String keyword = '';

  @override
  void initState() {
    super.initState();
    bloc = HistoryOrderBloc()..getData();
    _tabController = TabController(
        length: widget.params.listStatusOrder.length, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<HistoryOrderBloc, HistoryOrderState>(
        listener: (context, state) {},
        child: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: colorWhite,
                appBar: AppBar(
                    backgroundColor: colorMain,
                    elevation: 0,
                    leading: const Padding(
                      padding: EdgeInsets.only(
                        left: 23,
                      ),
                      child: BackButton(color: colorWhite),
                    ),
                    title: const Text('Đơn đã mua')),
                body: Column(children: [
                  _tabBar(
                    context,
                  ),
                  Expanded(
                    child: ColoredBox(
                      color: const Color(0xFFECECEE),
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            _tabController.index = value;
                          });
                          bloc.onChangeTab(value + 1);
                        },
                        itemCount: _tabController.length,
                        itemBuilder: (c, i) {
                          return BlocProvider(
                            key: ObjectKey(state.tab),
                            create: (context) => HistoryOrderTabBloc(
                              tab: i + 1,
                            ),
                            child: HistoryOrderTab(
                              params: HistoryOrderTabParms(
                                  status: state.tab,
                                  onReload: () {},
                                  idUser: state.idUser),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ])
                //  const NotActivePage(
                //     isAppBar: false,
                //   ),
                );
          },
        ),
      ),
    );
  }

  Widget _tabBar(
    BuildContext context,
  ) {
    return Container(
      color: context.colorScheme.background,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: TabBar(
          isScrollable: true, // Thêm dòng này
          onTap: (value) async {
            _pageController.jumpToPage(value);
            bloc.onChangeTab(value + 1);
          },
          controller: _tabController,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: context.colorScheme.primary,
            ),
          ),
          tabs: widget.params.listStatusOrder
              .map(
                (e) => Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      e.name ?? '',
                      style: textTheme.bodyMedium?.copyWith(
                        color: _tabController.index ==
                                widget.params.listStatusOrder.indexOf(e)
                            ? context
                                .appColorScheme.colorExtendedTextFieldCursor
                            : context.appColorScheme.colorIconInactive,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
