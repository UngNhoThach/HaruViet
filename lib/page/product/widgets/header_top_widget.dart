import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/shadows.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/home/widgets/flash_deals.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/utils/commons.dart';

class TopCategoriesHeader extends StatelessWidget {
  final String title;
  final bool isTimer;
  final bool isBorder;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final bool isViewMore;
  final Color? colorText;

  const TopCategoriesHeader({
    Key? key,
    this.backgroundColor,
    this.colorText,
    required this.title,
    this.isViewMore = true,
    required this.isTimer,
    this.isBorder = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: isBorder
          ? BoxDecoration(
              color: backgroundColor ?? colorBlueGray01, boxShadow: shadowE1)
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title with bold style
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: colorText),
          ),
          if (isTimer) const FlashDealsTimer(),
          TextButton(
            onPressed: onPressed ??
                () {
                  routeService.pushNamed(
                    Routes.productListPage,
                    arguments: ProductListPageParams(),
                  );
                },
            child: isViewMore
                ? Text(
                    "Xem tất cả",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            colorText ?? Theme.of(context).primaryColorLight),
                  )
                : space0,
          )
        ],
      ),
    );
  }
}

class CurvedBackgroundPainter extends CustomPainter {
  final Color color;

  CurvedBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Define the path for the curved shape
    final path = Path()
      ..moveTo(0, size.height * 0)
      ..quadraticBezierTo(
        size.width * 0,
        0,
        size.width * 0,
        0,
      )
      ..lineTo(size.width * 0, 0)
      ..quadraticBezierTo(
        size.width * 0.2,
        0,
        size.width,
        size.height * 0.2,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // Draw the curved background
    canvas.drawPath(path, paint);

    // Draw the line extending below the elements
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 0.0
      ..style = PaintingStyle.stroke;

    final startY = size.height - 30; // Line starting point below title
    final endY = startY;

    canvas.drawLine(
      Offset(size.width * 0.2, startY),
      Offset(size.width, endY),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
