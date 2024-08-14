/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/filter_high.png
  AssetGenImage get filterHigh =>
      const AssetGenImage('assets/icons/filter_high.png');

  /// File path: assets/icons/filter_hot-deal.png
  AssetGenImage get filterHotDeal =>
      const AssetGenImage('assets/icons/filter_hot-deal.png');

  /// File path: assets/icons/filter_low.png
  AssetGenImage get filterLow =>
      const AssetGenImage('assets/icons/filter_low.png');

  /// File path: assets/icons/filter_price.png
  AssetGenImage get filterPrice =>
      const AssetGenImage('assets/icons/filter_price.png');

  /// File path: assets/icons/ic_about_us.png
  AssetGenImage get icAboutUs =>
      const AssetGenImage('assets/icons/ic_about_us.png');

  /// File path: assets/icons/ic_invite_friends.png
  AssetGenImage get icInviteFriends =>
      const AssetGenImage('assets/icons/ic_invite_friends.png');

  /// File path: assets/icons/ic_logout.png
  AssetGenImage get icLogout =>
      const AssetGenImage('assets/icons/ic_logout.png');

  /// File path: assets/icons/ic_notification.png
  AssetGenImage get icNotification =>
      const AssetGenImage('assets/icons/ic_notification.png');

  /// File path: assets/icons/ic_payment.png
  AssetGenImage get icPayment =>
      const AssetGenImage('assets/icons/ic_payment.png');

  /// File path: assets/icons/icon_share.png
  AssetGenImage get iconShare =>
      const AssetGenImage('assets/icons/icon_share.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        filterHigh,
        filterHotDeal,
        filterLow,
        filterPrice,
        icAboutUs,
        icInviteFriends,
        icLogout,
        icNotification,
        icPayment,
        iconShare
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/education.png
  AssetGenImage get education =>
      const AssetGenImage('assets/images/education.png');

  /// File path: assets/images/facebook.png
  AssetGenImage get facebook =>
      const AssetGenImage('assets/images/facebook.png');

  /// File path: assets/images/google.png
  AssetGenImage get google => const AssetGenImage('assets/images/google.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_2.png
  AssetGenImage get logo2 => const AssetGenImage('assets/images/logo_2.png');

  /// File path: assets/images/maneuver.png
  AssetGenImage get maneuver =>
      const AssetGenImage('assets/images/maneuver.png');

  /// File path: assets/images/qr_png.png
  AssetGenImage get qrPng => const AssetGenImage('assets/images/qr_png.png');

  /// File path: assets/images/recruitment.png
  AssetGenImage get recruitment =>
      const AssetGenImage('assets/images/recruitment.png');

  /// File path: assets/images/shopping.png
  AssetGenImage get shopping =>
      const AssetGenImage('assets/images/shopping.png');

  /// File path: assets/images/user_information.png
  AssetGenImage get userInformation =>
      const AssetGenImage('assets/images/user_information.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        education,
        facebook,
        google,
        logo,
        logo2,
        maneuver,
        qrPng,
        recruitment,
        shopping,
        userInformation
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
