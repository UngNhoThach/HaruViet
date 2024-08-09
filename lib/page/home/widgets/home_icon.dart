import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/shadows.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomePageIcon extends StatelessWidget {
  final String assetImageString;
  final String itemString;
  final dynamic destinationWidget;
  final String notifyNumber;
  final void Function()? onTap;

  const HomePageIcon({
    super.key,
    this.destinationWidget,
    required this.assetImageString,
    required this.itemString,
    required this.notifyNumber,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => destinationWidget));
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

class ChildCategory extends StatelessWidget {
  final String assetImageString;
  final String itemString;
  final dynamic destinationWidget;
  final void Function()? onTap;

  const ChildCategory({
    super.key,
    this.destinationWidget,
    required this.assetImageString,
    required this.itemString,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => destinationWidget));
          },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: 76,
            height: 60,
            child: Wrap(alignment: WrapAlignment.center, children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: colorGray02),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,

                    fadeOutDuration: const Duration(seconds: 1),
                    //  const Duration(seconds: 3),
                    imageUrl: assetImageString,
                    width: 32,
                    height: 32,
                    placeholder: (context, url) => const ImageProductShimer(
                      width: 32,
                      height: 32,
                    ), // Use the custom shimmer component
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
                width: double.infinity,
              ),
              Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                itemString,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          ),
        ],
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
