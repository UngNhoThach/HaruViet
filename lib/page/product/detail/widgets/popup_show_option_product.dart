import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/component/title_btottom/title_bottom_sheet_wrapper.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/product/detail/product_detail_bloc.dart';
import 'package:haruviet/page/product/detail/product_detail_state.dart';

class PopupCreateTerminationResignation extends StatefulWidget {
  const PopupCreateTerminationResignation._(
      {required this.onReload,
      this.widgetValueSelect,
      required this.widgetButton,
      required this.widgetCountQuality,
      this.widgetImage,
      required this.bloc,
      Key? key})
      : super(key: key);

  final VoidCallback onReload;
  final Widget? widgetValueSelect;
  final Widget widgetButton;
  final Widget? widgetImage;

  final Widget widgetCountQuality;

  final ProductDetailBloc bloc; // Store the bloc instance

  static Future<void> show(
    BuildContext context, {
    Widget? widgetValueSelect,
    Widget? widgetImage,
    required Widget widgetCountQuality,
    required Widget widgetButton,
    required VoidCallback onReload,
    required ProductDetailBloc bloc,
    required ProductDetailState state,
  }) {
    return showAppModalBottomSheetV3<void>(
      context: context,
      child: BlocProvider.value(
        value: bloc, // Provide the existing bloc instance
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            return BlocSelector<ProductDetailBloc, ProductDetailState, bool>(
              selector: (selector) {
                return selector.isSoldOut;
              },
              builder: (context, state) {
                return PopupCreateTerminationResignation._(
                  onReload: onReload,
                  widgetButton: widgetButton,
                  widgetValueSelect: widgetValueSelect,
                  widgetImage: widgetImage,
                  widgetCountQuality: widgetCountQuality,
                  bloc: bloc, // Pass the bloc instance to the widget
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  State<PopupCreateTerminationResignation> createState() =>
      _PopupChangePersonalInformationState();
}

class _PopupChangePersonalInformationState
    extends State<PopupCreateTerminationResignation> {
  int indexSelected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TitleBottomSheetAutoHeightWrapper(
      bottomWidget: widget.widgetButton,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400.h),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                widget.widgetImage ?? space0,
                widget.widgetValueSelect ?? space0,
                spaceH10,
                widget.widgetCountQuality,
                spaceH16,
              ],
            ),
          );
        },
      ),
    );
  }
}
