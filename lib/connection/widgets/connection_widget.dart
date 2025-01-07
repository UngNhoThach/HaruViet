import 'package:haruviet/component/error/not_found_item.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';

class ConnectionWidget extends StatelessWidget {
  final void Function()? onPressed;
  const ConnectionWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DidntFoundItem(
      title: 'Thử lại',
      onPressed: onPressed,
      widget: Column(
        children: [
          spaceH100,
          const Text(
            'Kiểm tra kết nối!',
            style: TextStyle(),
          )
        ],
      ),
      isCartWidget: false,
    );
  }
}
