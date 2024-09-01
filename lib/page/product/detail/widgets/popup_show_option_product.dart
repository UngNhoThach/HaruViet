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
      //  required this.colorSelected,
      this.widgetImage,
      this.widgetColor,
      this.widgetSize,
      required this.widgetButton,
      required this.widgetCountQuality,
      required this.bloc,
      Key? key})
      : super(key: key);

  //  final String colorSelected;
  final VoidCallback onReload;
  final Widget? widgetImage;
  final Widget? widgetColor;
  final Widget? widgetSize;
  final Widget widgetButton;
  final Widget widgetCountQuality;
  final ProductDetailBloc bloc; // Store the bloc instance

  static Future<void> show(
    BuildContext context, {
    //  required String colorSelected,
    Widget? widgetImage,
    Widget? widgetColor,
    Widget? widgetSize,
    required Widget widgetCountQuality,
    required Widget widgetButton,
    required VoidCallback onReload,
    required ProductDetailBloc bloc,
    required ProductDetailState state,

    // Pass the bloc instance here
  }) {
    return showAppModalBottomSheetV3<void>(
      context: context,
      child: BlocProvider.value(
        value: bloc, // Provide the existing bloc instance
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            return BlocSelector<ProductDetailBloc, ProductDetailState, bool>(
              selector: (selector) {
                return selector.validBuyProductAttributes;
              },
              builder: (context, state) {
                return PopupCreateTerminationResignation._(
                  onReload: onReload,
                  widgetButton: widgetButton,
                  //       colorSelected: colorSelected,
                  widgetColor: widgetColor,
                  widgetImage: widgetImage,
                  widgetSize: widgetSize,
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
    // indexSelected = ColorWorkPlan.values.indexWhere(
    //     (element) => element == ColorWorkPlan.from(widget.colorSelected));
  }

  @override
  Widget build(BuildContext context) {
    return TitleBottomSheetAutoHeightWrapper(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxHeight: double.infinity, maxWidth: double.infinity),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.widgetImage ?? space0,
                widget.widgetColor ?? space0,
                widget.widgetSize ?? space0,
                // Column(
                //   children: [
                //     widget.widgetImage ?? space0,
                //     widget.widgetColor ?? space0,
                //     widget.widgetSize ?? space0,
                //   ],
                // ),
                spaceH10,
                widget.widgetCountQuality,
                spaceH16,
                widget.widgetButton,
                spaceH8,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
