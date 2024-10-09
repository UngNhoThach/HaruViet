import 'package:haruviet/component/button/solid_button.dart';
import 'package:haruviet/component/input/form_input.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/component/title_btottom/title_bottom_sheet_wrapper.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';

class PopupInputAddress extends StatefulWidget {
  const PopupInputAddress._({
    required this.isRequired,
    required this.onChange,
  });

  final bool isRequired;
  final void Function(String?) onChange;

  static Future<void> show(
    BuildContext context, {
    bool? isRequired,
    required void Function(String?) onChange,
  }) {
    return showAppModalBottomSheetV3<void>(
      context: context,
      child: PopupInputAddress._(
        isRequired: isRequired ?? true,
        onChange: onChange,
      ),
    );
  }

  @override
  State<PopupInputAddress> createState() => _PopupInputAddressState();
}

class _PopupInputAddressState extends State<PopupInputAddress> {
  String addressText = '';

  @override
  Widget build(BuildContext context) {
    return TitleBottomSheetAutoHeightWrapper(
      title: 'Nhập số nhà / đường',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormInput(
              isValidate: false,
              isDisplayTitle: false,
              title: '',
              onChanged: (password) {
                setState(() {
                  addressText = password;
                });
              },
            ),
            spaceH36,
            AppSolidButton.medium(
              context: context,
              disabledColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryColor,
              onPressed: widget.isRequired
                  ? (addressText.isNotEmpty
                      ? () {
                          widget.onChange(addressText);
                          context.justBack();
                        }
                      : null)
                  : () {
                      widget.onChange(addressText);
                      context.justBack();
                    },
              'Xác nhận',
            ),
            spaceH20,
          ],
        ),
      ),
    );
  }
}
