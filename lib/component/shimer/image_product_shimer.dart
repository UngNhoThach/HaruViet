// Widget Function(BuildContext, String)? placeholder

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageProductShimer extends StatelessWidget {
  final double width;
  final double height;

  const ImageProductShimer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 100,
        height: 90,
        color: Colors.white,
      ),
    );
  }
}
