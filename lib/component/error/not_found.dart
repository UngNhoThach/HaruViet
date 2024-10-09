import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DidntFound extends StatelessWidget {
  const DidntFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          spaceH16,
          Text(
            'Đang tải',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          ),
          LoadingAnimationWidget.horizontalRotatingDots(
            color: Theme.of(context).primaryColorLight,
            size: 40.r,
          ),
        ],
      ),
    );
  }
}
