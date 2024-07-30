import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseViewState<S extends BaseState, M extends BaseBloc<S>,
    W extends StatefulWidget> extends State<W> {
  late M bloc;

  @override
  void initState() {
    super.initState();
    createState();
    onBlocCreate();
  }

  M createState();

  void onBlocCreate() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider<M>(
      create: (_) => createState(),
      child: buildViewByState(context),
    );
  }

  Widget buildViewByState(BuildContext context) {
    return BlocBuilder<M, S>(
      builder: (context, state) {
        switch (state.viewState) {
          case ViewState.loading:
            return buildLoadingView(context);
          case ViewState.loaded:
            return buildLoadedView(context, state);
          case ViewState.error:
            return buildErrorView(context);
          default:
            return buildDefault();
        }
      },
    );
  }

  Widget buildDefault() {
    return Container();
  }

  Widget buildLoadedView(BuildContext context, S state);

  Widget buildLoadingView(BuildContext context) => const LoadingWidget();

  Widget buildErrorView(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          bloc.state.errorMsg,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
