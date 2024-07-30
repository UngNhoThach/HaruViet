import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';

@CopyWith()
class OrdersTabState extends BaseState {
  final bool isLoading;
  final bool isUnselected;
  final int tab;
  final String employeeId;
  final String fullName;
  final String domain;
  final int countChecked;
  final int countCheckedFolder;
  final int countCheckedDocument;
  final String? keyword;
  final int? parentId;
  final Map<int, String>? folderTree;
  final List<int> ids;

  const OrdersTabState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isLoading = false,
    this.isUnselected = false,
    this.countChecked = 0,
    this.countCheckedFolder = 0,
    this.countCheckedDocument = 0,
    this.tab = 0,
    this.employeeId = '',
    this.fullName = '',
    this.domain = '',
    this.keyword,
    this.ids = const [],
    this.parentId,
    this.folderTree,
  }) : super(viewState, errorMsg);
}
