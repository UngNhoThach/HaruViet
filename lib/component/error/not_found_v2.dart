import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';

class DidntFoundV2 extends StatelessWidget {
  const DidntFoundV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          spaceH16,
          const Text(
            'Không tìm thấy dữ liệu phù hợp',
            style: TextStyle(color: colorMainCover),
          )
        ],
      ),
    );
  }
}
