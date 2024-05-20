import 'package:eco_app/component/input/custom_count_textfield.dart';
import 'package:eco_app/component/loading_scaffold.dart';
import 'package:eco_app/component/popup/popup.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/const.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/cart/cart_bloc.dart';
import 'package:eco_app/page/cart/cart_sate.dart';
import 'package:eco_app/page/cart/models/cart_item_request.dart';
import 'package:eco_app/page/cart/models/cart_page_params.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.params});

  final CartPageParams params;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CartBloc()..getData();
  }

  footer(BuildContext context, CartState state) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Text(
                  "Tổng cộng",
                  style: textTheme.bodyMedium?.copyWith(
                      color: colorGray04, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.w),
                child: Text(
                  state.finalPrice == null
                      ? "\$${defaultCurrencyFormatter.format((state.finalPriceDefault ?? 0).toStringAsFixed(0))}"
                      : "\$${defaultCurrencyFormatter.format((state.finalPrice ?? 0).toStringAsFixed(0))}",
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

  createSubTitle(CartState state) {
    return Text("Tổng (${state.totalItem ?? 0}) sản phẩm",
        style: textTheme.bodyLarge
            ?.copyWith(color: colorGray04, fontWeight: FontWeight.w400));
  }

  createCartList(CartState state) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: colorGray01,
        height: 1,
        thickness: 10,
      ),
      shrinkWrap: true,
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
                            BlocSelector<CartBloc, CartState, CartItemRequest>(
                              selector: (state) {
                                return state.cartItemsRequest[index];
                              },
                              builder: (context, value) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        "\$${defaultCurrencyFormatter.format((value.price ?? 0).toStringAsFixed(0))}",
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: colorSuccess03,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      width: 110.w,
                                      child: CustomCountTextFormField(
                                        key: ObjectKey(
                                          state.checkValue,
                                        ),
                                        onChangedLeft: () {
                                          bloc.onChangeDecrementCounter(index);
                                        },
                                        onChangedRight: () {
                                          bloc.onChangeIncrementCounter(index);
                                        },
                                        initialValue: value.quality.toString(),
                                        onChanged: (value) {
                                          bloc.onChangeValueDirec(
                                              index, int.parse(value));
                                        },
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                            spaceH4,
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]));
      },
      itemCount: state.cartItemsRequest.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<CartBloc, CartState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        listener: (context, state) {
          if (state.isLoading) {
            showPopupLoading(context, text: 'Đang tải...');
          } else if (state.isSubmitSuccess) {
            // Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey.shade100,
              body: LoadingScaffold(
                isLoading: state.isLoading,
                child: Builder(builder: (context) {
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
                      footer(context, state)
                    ],
                  );
                }),
              ));
        }),
      ),
    );
  }
}
