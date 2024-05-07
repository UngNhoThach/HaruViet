import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/cart/models/cart_page_params.dart';
import 'package:eco_app/page/home/widgets/drawer_list_bloc.dart';
import 'package:eco_app/page/home/widgets/drawer_list_state.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerListPage extends StatefulWidget {
  const DrawerListPage({super.key});

  @override
  State<DrawerListPage> createState() => _DrawListState();
}

class _DrawListState extends State<DrawerListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late DrawerListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = DrawerListBloc();
    bloc.getData();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<DrawerListBloc, DrawerListState>(
        builder: (context, state) {
          return Drawer(
              child: Padding(
            padding: EdgeInsets.only(
              left: 8.w,
              right: 4,
              top: 60,
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: <Widget>[
                // Align(
                //                       alignment: Alignment.topCenter,
                //                       child: CircleAvatar(
                //                         radius: 56.r,
                //                         backgroundColor: colorBlueGray02,
                //                         child: CircleAvatar(
                //                             radius: 40.r,
                //                             backgroundColor: colorBlueGray02,
                //                             child: AspectRatio(
                //                               aspectRatio: 1,
                //                               child: Container(),
                //                             )),
                //                       ))
                //                   : Align(
                //                       alignment: Alignment.topCenter,
                //                       child: CircleAvatar(
                //                         radius: 56.r,
                //                         backgroundColor: Colors.white70,
                //                         child: CircleAvatar(
                //                             radius: 40.r,
                //                             child: AspectRatio(
                //                               aspectRatio: 1,
                //                               child: Container(
                //                                 decoration: BoxDecoration(
                //                                     border: Border.all(
                //                                         color: Colors
                //                                             .grey.shade400,
                //                                         width: 2.w),
                //                                     shape: BoxShape.circle,
                //                                     image: DecorationImage(
                //                                         image: NetworkImage(
                //                                             state.userInfoLogin
                //                                                     ?.avatar ??
                //                                                 ''),
                //                                         fit: BoxFit.contain)),
                //                               ),
                //                             )),
                //                       ),
                //                     ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 30.r,
                        backgroundColor: colorBackgroundWhite,
                        child: CircleAvatar(
                          radius: 38.r,
                          child: (state.dataUser?.avatar == "" ||
                                  state.dataUser?.avatar == null)
                              ? AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                      decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(65.r)),
                                    color:
                                        colorBackgroundWhite.withOpacity(0.5),
                                  )),
                                )
                              : AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400,
                                            width: 2.w),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${state.dataUser?.avatar}'),
                                            fit: BoxFit.contain)),
                                  )),
                        )

                        //
                        ),
                    spaceW12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Xin chào,",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: colorPrimary,
                          ),
                        ),
                        spaceH4,
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(
                                state.dataUser?.name ?? '',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorBlackTileItem,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                spaceH16,
                InkWell(
                    onTap: () {
                      routeService.pushNamed(Routes.cartPage,
                          arguments: CartPageParams(isAppBar: true));
                    },
                    child: ListTile(
                      title: Text(
                        'Giỏ hàng',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const Icon(Icons.shopping_basket),
                    )),
                InkWell(
                    onTap: () {
                      routeService.pushNamed(Routes.categoryPage);
                    },
                    child: ListTile(
                      title: Text(
                        'Lịch sử mua hàng',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const Icon(Icons.dashboard),
                    )),
                InkWell(
                    onTap: () {
                      // routeService.pushNamed(Routes.categoryPage);
                    },
                    child: ListTile(
                      title: Text(
                        'Chính sách đổi trả',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const Icon(Icons.repeat_rounded),
                    )),
                InkWell(
                    onTap: () {
                      // routeService.pushNamed(Routes.categoryPage);
                    },
                    child: ListTile(
                      title: Text(
                        'Hỏi đáp',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const Icon(Icons.question_mark),
                    )),
                InkWell(
                    onTap: () {
                      routeService.pushNamed(Routes.supportPage);
                    },
                    child: ListTile(
                      title: Text(
                        'Hỗ trợ',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const Icon(Icons.support_agent_rounded),
                    )),
                const Divider(),
                InkWell(
                    onTap: () {},
                    child: ListTile(
                      title: Text(
                        'Cài đăt',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const Icon(Icons.settings),
                    )),
                InkWell(
                    onTap: () {
                      routeService.pushNamed(
                        Routes.aboutPage,
                      );
                    },
                    child: ListTile(
                      title: Text(
                        'Về chúng tôi',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const Icon(Icons.help, color: Colors.blue),
                    )),
              ],
            ),
          ));
        },
      ),
    );
  }
}
