import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/page/view_data_web/view_data_web_bloc.dart';
import 'package:haruviet/page/view_data_web/view_data_web_state.dart';
import 'package:haruviet/page/view_data_web/widgets/view_data_web_params.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewDataWebPage extends StatefulWidget {
  const ViewDataWebPage({super.key, required this.params});
  final ViewDataWebPageParams params;

  @override
  State<ViewDataWebPage> createState() => _ViewDataWebPageState();
}

class _ViewDataWebPageState extends State<ViewDataWebPage> {
  // variables and functions

  late ViewDataWebBloc bloc;
  late String domain;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    bloc = ViewDataWebBloc()
      ..getData(
        initialUrl: widget.params.url,
      );

    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
  }

  @override
  void dispose() {
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
        appBar: AppBar(title: Text(widget.params.title)),
        body: BlocBuilder<ViewDataWebBloc, ViewDataWebState>(
          builder: (context, state) {
            return !state.isLoading
                ? WebViewWidget(controller: state.controller!)
                : const LoadingLogo();
          },
        ),
      ),
    );
  }
}
