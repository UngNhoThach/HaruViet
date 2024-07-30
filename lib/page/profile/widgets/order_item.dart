import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/shadows.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class OrderItem extends StatelessWidget {
  final String assetImageString;
  final String itemString;
  final dynamic destinationWidget;
  final String notifyNumber;
  final String? iconString;
  final bool isSelected;
  const OrderItem({
    super.key,
    this.destinationWidget,
    required this.assetImageString,
    required this.itemString,
    required this.notifyNumber,
    this.iconString,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        destinationWidget != null
            ? Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => destinationWidget))
            : null;
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 60,
            height: 55,
            decoration: BoxDecoration(
              color: isSelected ? Colors.green[100] : colorGray01,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: shadowE2,
            ),
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Wrap(alignment: WrapAlignment.center, children: [
              Center(
                child: Image.asset(
                  width: 30,
                  height: 30,
                  assetImageString,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 20,
                width: double.infinity,
              ),
              Text(
                textAlign: TextAlign.center,
                itemString,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          ),
          Positioned(
            top: -6,
            right: -6,
            child: badges.Badge(
              badgeContent: Text(
                notifyNumber,
                style: const TextStyle(color: Colors.white),
              ),
              showBadge: notifyNumber == "0" ? false : true,
            ),
          )
        ],
      ),
      // Stack(
      //   clipBehavior: Clip.none,
      //   children: [
      //     Container(
      //       width: 58.w,
      //       height: 36.h,
      //       padding: EdgeInsets.only(top: 8.h),
      //       decoration: BoxDecoration(
      //         color: isSelected ? Colors.green[100] : colorGray02,
      //         borderRadius: BorderRadius.circular(6.r),
      //       ),
      //       child: Wrap(alignment: WrapAlignment.center, children: [
      //         const Icon(
      //           Icons.delivery_dining,
      //           color: colorGray04,
      //         ),
      //         spaceH16,
      //         Text(
      //           textAlign: TextAlign.center,
      //           itemString,
      //           style: TextStyle(
      //               fontSize: 12.sp,
      //               fontWeight: FontWeight.w500,
      //               color: isSelected ? Colors.green[400] : colorGray04),
      //         ),
      //       ]),
      //     ),
      //     Positioned(
      //       top: -6,
      //       right: -6,
      //       child: badges.Badge(
      //         badgeContent: Text(
      //           notifyNumber,
      //           style: const TextStyle(color: Colors.white),
      //         ),
      //         showBadge: notifyNumber == "0" ? false : true,
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}

class OrderItem1 extends StatelessWidget {
  final String assetImageString;
  final String itemString;
  final String route;
  const OrderItem1({
    super.key,
    required this.route,
    required this.assetImageString,
    required this.itemString,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // try {
        //   routeService.pushNamed(route);
        // } catch (e, s) {
        //   print("$e + $s");
        // }
      },
      child: Container(
        width: 55,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFE9F4FE),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: shadowE2,
        ),
        padding: const EdgeInsets.only(
          top: 15,
        ),
        child: Wrap(children: [
          Center(
            child: Image.asset(
              width: 30,
              height: 30,
              assetImageString,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          Text(
            textAlign: TextAlign.center,
            itemString,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
      ),
    );
  }
}

class ItemIcon extends StatelessWidget {
  final String assetImageString;
  const ItemIcon({
    super.key,
    required this.assetImageString,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 55,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFE9F4FE),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: shadowE2,
        ),
        padding: const EdgeInsets.only(
          top: 15,
        ),
        child: Wrap(children: [
          Center(
            child: Image.asset(
              width: 30,
              height: 30,
              assetImageString,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
        ]),
      ),
    );
  }
}
