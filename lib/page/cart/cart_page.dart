import 'package:haruviet/component/error/error_internet.dart';
import 'package:haruviet/component/error/not_found_item.dart';
import 'package:haruviet/component/input/custom_count_textfield.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/database_local/product/models/cart_model.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/helper/theme.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/cart/cart_bloc.dart';
import 'package:haruviet/page/cart/cart_sate.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.params}) : super(key: key);

  final CartPageParams params;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // variables and functions
  late CartBloc bloc;
  late String domain;

  int splitCurrency(String currency) {
    List<String> parts = currency.split('.');
    int wholePart = int.parse(parts[0]);
    return wholePart;
  }

  @override
  void initState() {
    domain = context.read<UserBloc>().state.subDomain ?? '';
    bloc = CartBloc(context)..getData();
    super.initState();
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
                // ? "\$${defaultCurrencyFormatter.format((state.finalPriceDefault ?? 0).toStringAsFixed(0))}"
                //   : "\$${defaultCurrencyFormatter.format((state.finalPrice ?? 0).toStringAsFixed(0))}",
                child: Text(
                  state.finalPrice == null
                      ? "\$${state.finalPriceDefault ?? 0}"
                      : "\$${state.finalPrice ?? 0}",
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
                  (state.userInfoLogin?.isLogin == false ||
                          state.userInfoLogin == null)
                      ? {
                          routeService.pushNamed(
                            Routes.login,
                            arguments: SignInParams(typeDirec: 1),
                          )
                        }
                      : routeService.pushNamed(
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

  createCartList(CartState state, CartProvider cart) {
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
              key: ValueKey(state.productsList[index].idProduct),
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                bloc.onDeletaItems(index: index);
                const Duration(milliseconds: 200);
              }),
              children: [
                SlidableAction(
                  key: ValueKey(state.productsList),
                  onPressed: (context) {
                    bloc.onDeletaItems(index: index);
                    //    cart.addTotalPrice(productPrice)
                    // await CartDatabase.instance
                    //     .deleteCart(state.productsList[index].idProduct);
                    //     setState(() {});
                    //   bloc.onDeleteItem(index: index);
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
                        '$domain${state.productsList[index].imageProduct}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const ErrorInternet();
                          // Image.asset(
                          //   'assets/images/default_image.png',
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          // );
                        },
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
                                state.productsList[index].nameProduct,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Mã sp: ${state.productsList[index].description} | ",
                                    style: textTheme.labelMedium
                                        ?.copyWith(color: colorGray03),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                spaceW12,
                                Text(
                                  "Toshiba",
                                  style: textTheme.labelMedium
                                      ?.copyWith(color: colorError03),
                                ),
                                spaceW6,
                              ],
                            ),
                            spaceH6,
                            BlocSelector<CartBloc, CartState, Products>(
                              selector: (state) {
                                return state.productsList[index];
                              },
                              builder: (context, value) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(value.priceProduct,
                                        // "\$${defaultCurrencyFormatter.format((int.parse(value.priceProduct)).toStringAsFixed(0))}",
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: colorSuccess03,
                                            fontWeight: FontWeight.w400)),
                                    Consumer<CartProvider>(
                                      builder: (context, provider, child) {
                                        return SizedBox(
                                          width: 110.w,
                                          child: CustomCountTextFormField(
                                            key: ObjectKey(
                                              state.checkValue,
                                            ),
                                            onChangedLeft: () {
                                              bloc.onChangeDecrementCounter(
                                                  index);
                                            },
                                            onChangedRight: () {
                                              bloc.onChangeIncrementCounter(
                                                  index);
                                            },
                                            initialValue: value
                                                .totalQuantity.value
                                                .toString(),
                                            onChanged: (value) {
                                              bloc.onChangeValueDirec(
                                                index: index,
                                                value: int.parse(value),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
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
      itemCount: state.productsList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<CartBloc, CartState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        listener: (context, state) {
          // }
        },
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          return Scaffold(
              appBar: widget.params.isAppBar
                  ? AppBar(
                      centerTitle: true,
                      title: Text(
                        'Giỏ hàng',
                        style: textTheme.titleMedium?.copyWith(
                            color: colorWhite, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: colorMain,
                    )
                  : null,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey.shade100,
              body: state.isLoading
                  ? const LoadingLogo()
                  : state.totalItem == 0
                      ? _didFoundItem(context)
                      : LoadingScaffold(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      createSubTitle(state),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: createCartList(state, cart),
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

  Widget _didFoundItem(BuildContext context) {
    return const DidntFoundItem(
      isCartWidget: true,
    );
  }
}
