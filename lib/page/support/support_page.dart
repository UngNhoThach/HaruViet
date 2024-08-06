// ignore_for_file: sort_child_properties_last

import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/support/support_bloc.dart';
import 'package:haruviet/page/support/support_sate.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
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
  late SupportBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SupportBloc()..getData();
  }

  List<int> counterList = [];

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
                    children: [],
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
