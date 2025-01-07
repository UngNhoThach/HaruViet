import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:haruviet/component/input/search_bar.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_product.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';

import 'cart_order_voucher_bloc.dart';
import 'cart_order_voucher_state.dart';
import 'widgets/cart_order_voucher_params.dart';

class CartOrderVoucherPage extends StatefulWidget {
  final CartOrderVoucherParams params;

  const CartOrderVoucherPage({
    super.key,
    required this.params,
  });

  @override
  State<CartOrderVoucherPage> createState() => _CartOrderVoucherPageState();
}

class _CartOrderVoucherPageState extends State<CartOrderVoucherPage> {
  // variables and functions
  late CartOrderVoucherBloc bloc;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  final TextStyle styleSubTitle = const TextStyle(
    color: colorGray04,
    fontSize: 13,
  );
  final TextStyle? styleSubPrice = textTheme.titleSmall?.copyWith(
    color: colorSuccess03,
  );
  final TextStyle? styleTitle = textTheme.bodyLarge
      ?.copyWith(color: colorBlack, fontWeight: FontWeight.bold);

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
    bloc = CartOrderVoucherBloc()..getData(params: widget.params);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  List<int> counterList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<CartOrderVoucherBloc, CartOrderVoucherState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        listener: (context, state) {},
        child: BlocBuilder<CartOrderVoucherBloc, CartOrderVoucherState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: colorWhite),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                centerTitle: true,
                title: const Text('Áp dụng voucher'),
              ),
              body: state.isLoading
                  ? const LoadingLogo()
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: AppSearchBar(
                            hintText: 'Nhập mã voucher',
                            autofocus: true,
                            focusNode: focusNode,
                            controller: searchController,
                            onChanged: (keyword) {
                              bloc.onKeywordChanged(keyword: keyword);
                            },
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index.isOdd) {
                                return const Divider(
                                  color: colorBlueGray02,
                                );
                              }
                              final itemIndex = index ~/ 2;
                              if (itemIndex < state.productSearchList.length) {
                                final item = state.productSearchList[itemIndex];
                                return itemSearchVoucher(
                                  isSelected: state.voucherSelected == null
                                      ? false
                                      : state.voucherSelected!.id == item.id,
                                  context,
                                  data: item,
                                  index: itemIndex,
                                );
                              }
                              return space0;
                            },
                            childCount: state.productSearchList.length * 2 -
                                1, // Account for dividers
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          fillOverscroll: true,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                height: 160.h,
                                child: Column(
                                  children: [
                                    spaceH10,
                                    BlocSelector<CartOrderVoucherBloc,
                                        CartOrderVoucherState, bool>(
                                      selector: (selected) {
                                        return selected.isVoucherSelected;
                                      },
                                      builder: (context, selected) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                spaceH8,
                                                state.codeSelected == ''
                                                    ? space0
                                                    : Text(
                                                        "Mã đã chọn",
                                                        style: styleSubTitle,
                                                      ),
                                                spaceH8,
                                                state.discountAmount == 0
                                                    ? space0
                                                    : Text(
                                                        "Giảm giá",
                                                        style: styleSubTitle,
                                                      ),
                                                spaceH8,
                                                Text("Tạm tính",
                                                    style: styleSubTitle),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                spaceH8,
                                                state.codeSelected == ''
                                                    ? space0
                                                    : Text(
                                                        maxLines: 1,
                                                        state.codeSelected!
                                                            .substring(1, 6),
                                                        style: styleSubPrice),
                                                spaceH8,
                                                state.discountAmount == 0
                                                    ? space0
                                                    : Text(
                                                        '- ${defaultCurrencyVNDFormatter.formatString((state.discountAmount).toString())}',
                                                        style: styleSubPrice),
                                                spaceH8,
                                                Text(
                                                  defaultCurrencyVNDFormatter
                                                      .formatString(((state
                                                                  .totalPrice -
                                                              state
                                                                  .discountAmount))
                                                          .toString()),
                                                  style: textTheme.titleLarge
                                                      ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    spaceH16,
                                    AppSolidButton.medium(
                                      context: context,
                                      'Áp dụng',
                                      textStyle: textTheme.bodyLarge,
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        widget.params.voucherMethodFuc(
                                            codeSelected:
                                                state.codeSelected ?? '',
                                            totalPrice: state.totalPrice,
                                            discountAmount:
                                                state.discountAmount);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget itemSearchVoucher(
    BuildContext context, {
    required bool isSelected,
    required SearchProduct data,
    required int index,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        bloc.onSelectedVoucher(
          voucherSelected: data,
        );
      },
      child: Container(
        color: isSelected ? colorSuccess02.withOpacity(0.6) : colorWhite,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '- ${data.price?.finalSearchPriceStr} (${data.name!.substring(1, 6)})',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    'Điều kiện: ${data.name ?? ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorBlackTileItem,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
