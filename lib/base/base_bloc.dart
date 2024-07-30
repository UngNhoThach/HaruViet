import 'package:haruviet/data/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseState {
  final ViewState viewState;
  final String errorMsg;

  const BaseState(this.viewState, this.errorMsg);
}

abstract class BaseBloc<S> extends Cubit<S> {
  BaseBloc(super.initialState);
}
