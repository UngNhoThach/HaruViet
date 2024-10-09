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
          Text(
            'Không tìm thấy dữ liệu phù hợp',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          )
        ],
      ),
    );
  }
}
