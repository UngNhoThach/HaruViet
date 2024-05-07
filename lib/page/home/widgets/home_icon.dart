import 'package:eco_app/helper/shadows.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomePageIcon extends StatelessWidget {
  final String assetImageString;
  final String itemString;
  final dynamic destinationWidget;
  final String notifyNumber;

  const HomePageIcon({
    super.key,
    this.destinationWidget,
    required this.assetImageString,
    required this.itemString,
    required this.notifyNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => destinationWidget));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
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
    );
  }
}

class HomePageIcon1 extends StatelessWidget {
  final String assetImageString;
  final String itemString;
  final String route;
  const HomePageIcon1({
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
