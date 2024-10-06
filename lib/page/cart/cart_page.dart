import 'package:flutter/widgets.dart';
import 'package:haruviet/component/error/error_internet.dart';
import 'package:haruviet/component/error/not_found_item.dart';
import 'package:haruviet/component/input/custom_count_textfield.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/account/signin/widgets/signin_params.dart';
import 'package:haruviet/page/cart/cart_bloc.dart';
import 'package:haruviet/page/cart/cart_sate.dart';
import 'package:haruviet/page/cart/checkout/widgets/checkout_params.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
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
    domain = context.read<UserBloc>().state.subDomain ?? '';
    bloc = CartBloc(context)..getData();
    super.initState();
  }

  footer(BuildContext context, CartState state) {
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
                  color: colorMainCover,
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
                      : routeService.pushNamed(Routes.checkOutPage,
                          arguments: CheckoutParams(
                              weight: state.weight,
                              price: "",
                              discountOrder: state.discountOrder));
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
    return Text("Tổng (${state.totalItem ?? 0}) sản phẩm",
        style: textTheme.bodyLarge
            ?.copyWith(color: colorGray04, fontWeight: FontWeight.w400));
  }

  createCartList(CartState state, CartProviderV2 cart) {
    return BlocSelector<CartBloc, CartState, List<CartModelProduct>>(
      selector: (state) {
        return state.productsList;
      },
      builder: (context, data) {
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
            final item = data[index];
            final itemCheck = state.checkOrderPriceResponse[index];
            // Find the matching gift for the current product
            DataProductDetailResponse? matchedGift;
            if (itemCheck?.gift != null) {
              matchedGift = state.listGiftProduct?.firstWhere(
                (gift) =>
                    gift?.id == itemCheck?.gift?.giftId, // Match the giftId
                //    orElse: () => null, // Return null if no match is found
              );
            }

            // state
            return Slidable(
                key: ValueKey(item),
                // key: ObjectKey(state.totalItem),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(
                    motion: spaceH12,
                    key: ObjectKey(item),
                    onDismissed: () {
                      bloc.onDeletaItems(index: index);

                      // setState(() {});
                    },
                    // closeOnCancel: true,
                  ),
                  children: [
                    SlidableAction(
                      //   key: ObjectKey(item),
                      onPressed: (context) {
                        bloc.onDeletaItems(index: index);
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
                        color: colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(8.r),
                              width: 60.w,
                              height: 60.h,
                              child: Image.network(
                                '$domain${item.image}',
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const ErrorInternet();
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
                                      padding:
                                          EdgeInsets.only(right: 8.w, top: 4.h),
                                      child: Text(
                                        item.descriptions.name ?? '',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${item.descriptions.description} | ",
                                            style: textTheme.labelMedium
                                                ?.copyWith(color: colorGray03),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        spaceW12,
                                        Text(
                                          item.brand.name ?? '',
                                          style: textTheme.labelMedium
                                              ?.copyWith(color: colorError03),
                                        ),
                                        spaceW6,
                                      ],
                                    ),
                                    spaceH6,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                            defaultCurrencyVNDFormatter
                                                .formatString((item.price.price
                                                    .toString())),
                                            style: textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: colorSuccess03,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                        Consumer<CartProviderV2>(
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
                                                initialValue: item.totalQuantity
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
                                    ),
                                    if (itemCheck!.promotions != null &&
                                        itemCheck.promotions!.isNotEmpty) ...[
                                      const Divider(),
                                      Text('${itemCheck.promotions?[0]}',
                                          style: textTheme.bodyMedium?.copyWith(
                                              color: colorMainCover,
                                              fontWeight: FontWeight.w400)),
                                      spaceH6,
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        spaceH6,
                        if (matchedGift != null) ...[
                          _giftItem(item: matchedGift)
                        ]
                      ],
                    ),
                  ),
                ]));
          },
          itemCount: state.productsList.length,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProviderV2>(context);

    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<CartBloc, CartState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        listener: (context, state) {
          // }
        },
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
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
                body: ((state.totalItem == 0 || state.totalItem == null) &&
                        state.isLoading)
                    ? const LoadingLogo()
                    : LoadingScaffold(
                        isLoading: state.isLoading,
                        child: Builder(builder: (context) {
                          return !(state.totalItem == 0 ||
                                  state.totalItem == null)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 12.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                )
                              : _didFoundItem(context);
                        }),
                      )),
          );
        }),
      ),
    );
  }

  Widget _didFoundItem(BuildContext context) {
    return const DidntFoundItem(
      isCartWidget: true,
    );
  }

  Widget _giftItem({
    required DataProductDetailResponse item,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
      padding: const EdgeInsets.all(12), // Add padding for better spacing
      decoration: BoxDecoration(
        color: colorBlueGray01.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: colorSuccess03, width: 1.5), // Green border to highlight
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 2,
        //     offset: Offset(
        //         0, 1), // Shadow for slight elevation
        //   ),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gift icon to highlight that this is a gifted product
          Container(
            margin: EdgeInsets.all(8.r),
            width: 32.w,
            height: 16.h,
            child: Image.network(
              '$domain${item.image}',
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const ErrorInternet();
              },
            ),
          ),
          const SizedBox(width: 4), // Add spacing between icon and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tặng thêm',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold, // Bold to highlight the label
                  color: colorSuccess03, // Color to match with the gift context
                ),
              ),
              spaceH4,
              // Add space between image and text
              Text(
                item.descriptions?.name ?? '',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorMainCover,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
