import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';

class DidntFound extends StatelessWidget {
  const DidntFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          spaceH20,
          // Assets.images.emptyStates.image(
          //   height: 240.r,
          //   width: 240.r,
          // ),
        ],
      ),
    );
  }
}
