// ignore_for_file: sort_child_properties_last

import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/support/support_bloc.dart';
import 'package:eco_app/page/support/support_sate.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../component/popup/popup.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({
    super.key,
  });

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  // variables and functions
  int _counter = 0;
  late SupportBloc bloc;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bloc = SupportBloc()..getData();
  }

  List<int> counterList = [];

  footer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30.w),
                child: Text(
                  "Tổng cộng",
                  style: textTheme.bodyMedium?.copyWith(
                      color: colorGray04, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30.w),
                child: Text(
                  "\$9.000.00 vnd",
                  style: textTheme.bodyLarge?.copyWith(
                      color: colorSuccess03, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          spaceH6,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // CheckOutPage or AddressPage
                  routeService.pushNamed(
                    Routes.addressPage,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorMain,
                ),
                child: const Text(
                  "Tiến hành đặt hàng",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              spaceW16,
            ],
          ),
          spaceH8,
        ],
      ),
    );
  }

  createSubTitle(SupportState state) {
    return Text("Tổng (${state.totalItem}) sản phẩm",
        style: textTheme.bodyMedium
            ?.copyWith(color: colorGray04, fontWeight: FontWeight.w400));
  }

  createCartList(SupportState state) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: colorGray01,
        height: 1,
        thickness: 10,
      ),
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Slidable(
            key: ValueKey(state.totalItem),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                bloc.onDeleteItem(index: index);
              }),
              children: [
                SlidableAction(
                  key: ValueKey(state.totalItem),
                  onPressed: (context) {
                    setState(() {
                      bloc.onDeleteItem(index: index);
                    });
                  },
                  backgroundColor: colorMain,
                  foregroundColor: colorWhite,
                  icon: Icons.delete,
                  label: 'Xoá',
                ),
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: colorPrimary,
                  foregroundColor: colorWhite,
                  icon: Icons.share,
                  label: 'Chia sẻ',
                ),
              ],
            ),
            child: Stack(children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8.r),
                      width: 60.w,
                      height: 60.h,
                      child: Image.network(
                        state.listCategories[index].image.toString(),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 8.w, top: 4.h),
                              child: Text(
                                '${state.listCategories[index].name}',
                                maxLines: 2,
                                softWrap: true,
                                style: const TextStyle(
                                    color: colorBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            spaceH6,
                            Row(
                              children: [
                                Text(
                                  "Mã sp: ${state.listCategories[index].code} | ",
                                  style: textTheme.labelMedium
                                      ?.copyWith(color: colorGray03),
                                ),
                                Text(
                                  "Toshiba",
                                  maxLines: null,
                                  style: textTheme.labelMedium
                                      ?.copyWith(color: colorGray03),
                                ),
                              ],
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("\$${state.listCategories[index].price}",
                                      style: textTheme.bodyMedium?.copyWith(
                                          color: colorSuccess03,
                                          fontWeight: FontWeight.w400)),
                                  Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            _decrementCounter();
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            size: 24.sp,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        Container(
                                          color: Colors.grey.shade200,
                                          padding: EdgeInsets.only(
                                              bottom: 4.h,
                                              right: 12.w,
                                              left: 12.w,
                                              top: 4.h),
                                          child: Text(
                                            "${state.listCategories[index].amount}",
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _incrementCounter();
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 24.sp,
                                            color: Colors.grey.shade700,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 100,
                    )
                  ],
                ),
              )
            ]));
      },
      itemCount: state.listCategories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<SupportBloc, SupportState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        listener: (context, state) {
          if (state.isLoading) {
            showPopupLoading(context, text: 'Đang tải...');
          } else {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<SupportBloc, SupportState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: colorMain,
                title: const Text('Hỗ trợ'),
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey.shade100,
              body: Builder(
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            createSubTitle(state),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: createCartList(state),
                        ),
                      ),
                      footer(context)
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
