import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/connection.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/reponsitory/category/models/list_category_response/data_category.dart';
import 'package:haruviet/data/reponsitory/category/models/list_category_response/subcategory.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';
import 'package:haruviet/page/voucher/voucher_bloc.dart';
import 'package:haruviet/page/voucher/voucher_state.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({
    super.key,
    //required this.params
  });
  // final VoucherPageParams params;

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  // variables and functions

  // check connection
  late StreamSubscription connectionChangeStream;
  bool isOffline = false;

  final PagingController<int, DataCategory> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);
  FocusNode focusNode = FocusNode();

  late VoucherBloc bloc;
  late String domain;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

// check connection change
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    if (!connectionStatus.hasConnection) {
      isOffline = !connectionStatus.hasConnection;
    } else {}

    bloc = VoucherBloc()..getData();

    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc,
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<VoucherBloc, VoucherState>(
          builder: (context, state) {
            return SingleChildScrollView();
          },
        ),
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ShimmerEffect(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        separatorBuilder: (context, index) => spaceH12,
        itemCount: 12,
      ),
    );
  }

  Widget _category(
    BuildContext context, {
    required List<Subcategory> subcategory,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 16.h, bottom: 40.h, left: 6.w, right: 6.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: subcategory.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              routeService.pushNamed(Routes.productListPage,
                  arguments: ProductListPageParams(
                      onReload: () {},
                      //    categoryID: widget.params.idCategory,
                      subCategoryID: subcategory[index].id ?? ''));
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Wrap(alignment: WrapAlignment.center, children: [
                    CachedNetworkImage(
                      fadeOutDuration: const Duration(seconds: 2),
                      imageUrl: '$domain${subcategory[index].image ?? ''}',
                      width: 48.w,
                      height: 48.h,
                      // placeholder: (context, url) => ImageProductShimer(
                      //   width: 48.w,
                      //   height: 48.h,
                      // ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Text(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        subcategory[index].descriptions?.title ?? '',
                        style: textTheme.bodySmall?.copyWith(
                            color: colorBlack, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
