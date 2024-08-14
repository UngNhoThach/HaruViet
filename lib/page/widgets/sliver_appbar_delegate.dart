import 'package:flutter/widgets.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double? height;

  SliverAppBarDelegate({required this.child, this.height});

  @override
  double get minExtent =>
      height ?? 56.0; // Đảm bảo giá trị này phù hợp với nội dung

  @override
  double get maxExtent =>
      minExtent; // Đảm bảo maxExtent bằng minExtent nếu bạn không cần mở rộng header

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
