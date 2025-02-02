import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/add_address/add_address/widgets/add_address_params.dart';
import 'package:haruviet/page/add_address/address_bloc.dart';
import 'package:haruviet/page/add_address/address_state.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_address/widgets/address_params.dart';

class AddressPage extends StatefulWidget {
  final AddressParams params;
  const AddressPage({
    super.key,
    required this.params,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // variables and functions
  late AddressBloc bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // variables and functions

  @override
  void initState() {
    super.initState();
    bloc = AddressBloc()
      ..getData(
        isShipping: widget.params.isShipping,
        idAddressShipping: widget.params.idAddressShipping!,
      );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<AddressBloc, AddressState>(
        listener: (context, state) {},
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            return Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: colorWhite),
                    onPressed: widget.params.isShipping
                        ? () {
                            widget.params.returnAddress!(state.addressShipping);
                            Navigator.of(context).pop();
                          }
                        : () => Navigator.of(context).pop()),
                backgroundColor: Theme.of(context).primaryColor,
                title: const Text(
                  "Địa chỉ của tôi",
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
                          Expanded(
                            flex: 9,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.listAddresses.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                        color: colorGray02,
                                        height: 1,
                                        thickness: 10,
                                      ),
                                  itemBuilder: (context, index) {
                                    final item = state.listAddresses[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: colorWhite,
                                        border: Border.all(color: colorWhite),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: widget.params.isShipping
                                                  ? () => {
                                                        bloc.onChangeShippingAddress(
                                                          isDefault: false,
                                                          idAddresses:
                                                              item.id ?? '',
                                                          item: item,
                                                        ),
                                                        bloc.onUpdateIdShipping(
                                                            addressShipping:
                                                                item),
                                                      }
                                                  : null,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  widget.params.isShipping
                                                      ? Radio(
                                                          visualDensity:
                                                              const VisualDensity(
                                                                  horizontal:
                                                                      -4,
                                                                  vertical: -4),
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          value: item.isShipping
                                                              ? true
                                                              : false,
                                                          groupValue: true,
                                                          onChanged:
                                                              (isChecked) {
                                                            bloc.onChangeShippingAddress(
                                                              isDefault: false,
                                                              idAddresses:
                                                                  item.id ?? '',
                                                              item: item,
                                                            );
                                                            bloc.onUpdateIdShipping(
                                                                addressShipping:
                                                                    item);
                                                          },
                                                          activeColor: Theme.of(
                                                                  context)
                                                              .primaryColorLight,
                                                        )
                                                      : space0,
                                                  spaceW8,
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              state.addressDefaultId ==
                                                                      item.id
                                                                  ? "Địa chỉ (mặc định)"
                                                                  : "Địa chỉ",
                                                              style: textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                color:
                                                                    colorBlack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        spaceH6,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              item.phone ?? ' ',
                                                              style: textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                color:
                                                                    colorBlack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        spaceH6,
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '${item.house ?? ''}, ${item.ward ?? ''}, ${item.district ?? ''},${item.province ?? ''}',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                  color:
                                                                      colorGray04,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        spaceH12,
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              routeService.pushNamed(
                                                  Routes.addnewaddressPage,
                                                  arguments:
                                                      AddNewAddressParams(
                                                    isDefaultAddress:
                                                        (state.addressDefaultId ==
                                                                item.id)
                                                            ? true
                                                            : false,
                                                    dataListAddress: item,
                                                    isUpdate: true,
                                                    onReload: () {
                                                      bloc.getData(
                                                          isShipping: widget
                                                              .params
                                                              .isShipping,
                                                          idAddressShipping: widget
                                                              .params
                                                              .idAddressShipping!);
                                                    },
                                                  ));
                                            },
                                            child: SizedBox(
                                                height: 40.h,
                                                width: 36.w,
                                                child: Text(
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.end,
                                                    'sửa')),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                routeService.pushNamed(Routes.addnewaddressPage,
                                    arguments: AddNewAddressParams(
                                  onReload: () {
                                    bloc.getData(
                                        isShipping: widget.params.isShipping,
                                        idAddressShipping:
                                            widget.params.idAddressShipping!);
                                  },
                                ));
                              },
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colorPrimary,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: colorWhite,
                                      ),
                                      spaceW4,
                                      Text(
                                        'Thêm địa chỉ',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colorWhite,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      spaceW4,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              }),
            );
          },
        ),
      ),
    );
  }
}
