import 'package:haruviet/component/required_label/string_extension.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:flutter/cupertino.dart';

class RequiredLabel extends StatelessWidget {
  const RequiredLabel(this._label, {super.key, this.style});
  final String _label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            _label.capitalizeFirst,
            style: style,
          ),
        ),
        const Text(
          ' *',
          style: TextStyle(color: colorRed),
        )
      ],
    );
  }
}
