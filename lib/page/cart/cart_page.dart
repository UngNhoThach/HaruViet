import 'package:haruviet/component/error/not_found_item.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/get_cart_order_response/get_cart_order_response.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/cart/cart_bloc.dart';
import 'package:haruviet/page/cart/cart_sate.dart';
import 'package:haruviet/page/cart/checkout/widgets/checkout_params.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/cart/widgets/list_item.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final TextStyle styleSubTitle = const TextStyle(
    color: colorGray04,
    fontSize: 13,
  );
  final TextStyle? styleSubPrice = textTheme.bodyMedium?.copyWith(
    color: colorSuccess03,
  );

  final TextStyle? styleTitle = textTheme.bodyLarge
      ?.copyWith(color: colorBlack, fontWeight: FontWeight.bold);

  int splitCurrency(String currency) {
    List<String> parts = currency.split('.');
    int wholePart = int.parse(parts[0]);
    return wholePart;
  }

  @override
  void initState() {
    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
    bloc = CartBloc(context)..getData();
    super.initState();
  }

  footer(BuildContext context, CartState state, Color colorPrimaryCover) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (state.isFreeShipping) ...[
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                'Miễn phí vận chuyển',
                style: textTheme.titleLarge?.copyWith(
                  color: colorPrimaryCover,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const Divider(
              color: colorBlack,
            ),
            spaceH6,
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Text("Giảm giá", style: styleSubTitle),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.w),
                child: Text(
                    defaultCurrencyVNDFormatter.formatString(
                        ((state.discountOrder ?? 0).toStringAsFixed(0))),
                    style: styleSubPrice),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Text("Tổng cộng", style: styleTitle),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.w),
                child: Text(
                  state.finalPrice == null
                      ? defaultCurrencyVNDFormatter.formatString(
                          ((state.finalPriceDefault ?? 0).toStringAsFixed(0)))
                      : defaultCurrencyVNDFormatter.formatString(
                          ((state.finalPrice ?? 0).toStringAsFixed(0))),
                  style: textTheme.titleLarge
                      ?.copyWith(color: colorMain, fontWeight: FontWeight.bold),
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
                      : state.isNextPage
                          ? routeService.pushNamed(Routes.checkOutPage,
                              arguments: CheckoutParams(
                                  weight: state.weight,
                                  price: "",
                                  discountOrder: state.discountOrder))
                          : CustomSnackBar.showTop(
                              context, 'Vui lòng đợi cập nhật giỏ hàng!', null);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorMain,
                ),
                child: const Text(
                  "Tiến hành đặt hàng",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              spaceW30,
            ],
          ),
          spaceH8,
        ],
      ),
    );
  }

  createSubTitle(CartState state) {
    return Text("Tổng (${state.listItemsCartOrder.length ?? 0}) sản phẩm",
        style: textTheme.bodyLarge
            ?.copyWith(color: colorGray04, fontWeight: FontWeight.w400));
  }

  createCartList(List<GetCartOrderResponse> listItemsCartOrder,
      CartProviderV2 cart, Color colorPrimaryCover) {
    return ListView.separated(
      shrinkWrap: true,
      // update list when over items
      key: ObjectKey(bloc.state.isUpdateDone),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: listItemsCartOrder.length,
      itemBuilder: (context, index) {
        final item = listItemsCartOrder[index];
        return CartListItem(
          //    key: ObjectKey(item),
          item: item,
          domain: domain,
          index: index,
          quantityNotifier: ValueNotifier<int>(item.qty ?? 1),
          onCounterChanged: (newQty) {
            bloc.onUpdateItemFromCartOrder(
              rowId: item.rowId ?? '',
              id: item.id ?? '',
              newQty: newQty,
            );
          },
          onPressedDelete: (p0) => bloc.onDeleteItemFromCartOrder(
              rowId: item.rowId ?? '', index: index, idProduct: item.id ?? ''),
          onDismissed: () => bloc.onDeleteItemFromCartOrder(
              rowId: item.rowId ?? '', index: index, idProduct: item.id ?? ''),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProviderV2>(context);

    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<CartBloc, CartState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading ||
            previous.message != current.message,
        listener: (context, state) {
          //
          if (state.message != null) {
            CustomSnackBar.showTop(context, '${state.message}', 2);
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
            // buildWhen: (previous, current) =>
            //     previous.isUpdateDone != current.isUpdateDone,
            builder: (context, state) {
          Color colorPrimaryCover = Theme.of(context).primaryColorLight;
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
              body: (state.isLoading &&
                      (state.totalItem == 0 || state.totalItem == null))
                  ? const LoadingLogo()
                  : LoadingScaffold(
                      isLoading: state.isLoading,
                      child: Builder(builder: (context) {
                        return !(state.totalItem == 0 ||
                                state.totalItem == null)
                            ? Column(
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        await bloc.getData();
                                      },
                                      child: CustomScrollView(
                                        slivers: [
                                          SliverList(
                                            delegate: SliverChildListDelegate(
                                              [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.w,
                                                      vertical: 12.h),
                                                  child: createSubTitle(state),
                                                ),
                                                createCartList(
                                                  state.listItemsCartOrder,
                                                  cart,
                                                  colorPrimaryCover,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  footer(context, state, colorPrimaryCover),
                                ],
                              )
                            : _didFoundItem(context);
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
