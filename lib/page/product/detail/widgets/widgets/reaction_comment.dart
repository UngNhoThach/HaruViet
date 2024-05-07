import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

class ReactionComment extends StatefulWidget {
  const ReactionComment({
    super.key,
    required this.timeText,
    required this.numReact,
    required this.reactIcons,
    required this.listenBox,
    required this.isOpenBox,
    required this.onChangeReaction,
    required this.initReaction,
    required this.onTapReply,
    this.isReply = false,
    required this.onTapViewReact,
  });

  final String timeText;
  final int numReact;
  final List<int> reactIcons;
  final ValueChanged<bool> listenBox;
  final bool isOpenBox;
  final ValueChanged<int> onChangeReaction;
  final int initReaction;
  final VoidCallback onTapReply;
  final bool isReply;
  final VoidCallback onTapViewReact;

  @override
  State<ReactionComment> createState() => _ReactionCommentState();
}

class _ReactionCommentState extends State<ReactionComment>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AudioPlayer audioPlayer;

  int durationAnimationBox = 500;
  int durationAnimationBtnLongPress = 150;
  int durationAnimationBtnShortPress = 500;
  int durationAnimationIconWhenDrag = 150;
  int durationAnimationIconWhenRelease = 1000;

  // For long press btn
  late AnimationController animControlBtnLongPress, animControlBox;
  late Animation zoomIconLikeInBtn, tiltIconLikeInBtn, zoomTextLikeInBtn;
  late Animation fadeInBox;
  late Animation moveRightGroupIcon;
  late Animation pushIconLikeUp,
      pushIconLoveUp,
      pushIconLuvUp,
      pushIconHahaUp,
      pushIconWowUp,
      pushIconSadUp,
      pushIconAngryUp;
  late Animation zoomIconLike,
      zoomIconLove,
      zoomIconLuv,
      zoomIconHaha,
      zoomIconWow,
      zoomIconSad,
      zoomIconAngry;

  // For short press btn
  late AnimationController animControlBtnShortPress;
  late Animation zoomIconLikeInBtn2, tiltIconLikeInBtn2;

  // For zoom icon when drag
  late AnimationController animControlIconWhenDrag;
  late AnimationController animControlIconWhenDragInside;
  late AnimationController animControlIconWhenDragOutside;
  late AnimationController animControlBoxWhenDragOutside;
  late Animation zoomIconChosen, zoomIconNotChosen;
  late Animation zoomIconWhenDragOutside;
  late Animation zoomIconWhenDragInside;
  late Animation zoomBoxWhenDragOutside;
  late Animation zoomBoxIcon;

  // For jump icon when release
  late AnimationController animControlIconWhenRelease;
  late Animation zoomIconWhenRelease, moveUpIconWhenRelease;
  late Animation moveLeftIconLikeWhenRelease,
      moveLeftIconLoveWhenRelease,
      moveLeftIconHahaWhenRelease,
      moveLeftIconWowWhenRelease,
      moveLeftIconSadWhenRelease,
      moveLeftIconAngryWhenRelease,
      moveLeftIconLuvWhenRelease;

  Duration durationLongPress = const Duration(milliseconds: 250);
  late Timer holdTimer;
  bool isLongPress = false;
  bool isLiked = false;

  // 0 = nothing, 1 = like, 2 = love, 3 = luv, 4 = haha, 5 = wow, 6 = sad, 7 = angry
  late int whichIconUserChoose;

  int currentIconFocus = 0;
  int previousIconFocus = 0;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();

    // Button Like
    initAnimationBtnLike();

    // Box and Icons
    initAnimationBoxAndIcons();

    // Icon when drag
    initAnimationIconWhenDrag();

    // Icon when drag outside
    initAnimationIconWhenDragOutside();

    // Box when drag outside
    initAnimationBoxWhenDragOutside();

    // Icon when first drag
    initAnimationIconWhenDragInside();

    // Icon when release
    initAnimationIconWhenRelease();
  }

  initAnimationBtnLike() {
    // long press
    animControlBtnLongPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnLongPress));
    zoomIconLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
    tiltIconLikeInBtn =
        Tween(begin: 0.0, end: 0.2).animate(animControlBtnLongPress);
    zoomTextLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);

    zoomIconLikeInBtn.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn.addListener(() {
      setState(() {});
    });
    zoomTextLikeInBtn.addListener(() {
      setState(() {});
    });

    // short press
    animControlBtnShortPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnShortPress));
    zoomIconLikeInBtn2 =
        Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
    tiltIconLikeInBtn2 =
        Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

    zoomIconLikeInBtn2.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn2.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxAndIcons() {
    animControlBox = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationAnimationBox));

    // General
    moveRightGroupIcon = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 1.0)),
    );
    moveRightGroupIcon.addListener(() {
      setState(() {});
    });

    // Box
    fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.7, 1.0)),
    );
    fadeInBox.addListener(() {
      setState(() {});
    });

    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );

    pushIconLuvUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );
    zoomIconLuv = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.6, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.6, 1.0)),
    );

    pushIconLikeUp.addListener(() {
      setState(() {});
    });
    zoomIconLike.addListener(() {
      setState(() {});
    });
    pushIconLoveUp.addListener(() {
      setState(() {});
    });
    zoomIconLove.addListener(() {
      setState(() {});
    });
    pushIconLuvUp.addListener(() {
      setState(() {});
    });
    zoomIconLuv.addListener(() {
      setState(() {});
    });
    pushIconHahaUp.addListener(() {
      setState(() {});
    });
    zoomIconHaha.addListener(() {
      setState(() {});
    });
    pushIconWowUp.addListener(() {
      setState(() {});
    });
    zoomIconWow.addListener(() {
      setState(() {});
    });
    pushIconSadUp.addListener(() {
      setState(() {});
    });
    zoomIconSad.addListener(() {
      setState(() {});
    });
    pushIconAngryUp.addListener(() {
      setState(() {});
    });
    zoomIconAngry.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDrag() {
    animControlIconWhenDrag = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));

    zoomIconChosen =
        Tween(begin: 1.0, end: 1.5).animate(animControlIconWhenDrag);
    zoomIconNotChosen =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDrag);
    zoomBoxIcon =
        Tween(begin: 50.0, end: 40.0).animate(animControlIconWhenDrag);

    zoomIconChosen.addListener(() {
      setState(() {});
    });
    zoomIconNotChosen.addListener(() {
      setState(() {});
    });
    zoomBoxIcon.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragOutside() {
    animControlIconWhenDragOutside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragOutside =
        Tween(begin: 0.8, end: 1.0).animate(animControlIconWhenDragOutside);
    zoomIconWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxWhenDragOutside() {
    animControlBoxWhenDragOutside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomBoxWhenDragOutside =
        Tween(begin: 40.0, end: 50.0).animate(animControlBoxWhenDragOutside);
    zoomBoxWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragInside() {
    animControlIconWhenDragInside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragInside =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
    zoomIconWhenDragInside.addListener(() {
      setState(() {});
    });
    animControlIconWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isJustDragInside = false;
      }
    });
  }

  initAnimationIconWhenRelease() {
    animControlIconWhenRelease = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenRelease));

    zoomIconWhenRelease = Tween(begin: 1.8, end: 0.0).animate(CurvedAnimation(
        parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveUpIconWhenRelease = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveLeftIconLikeWhenRelease = Tween(begin: 20.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconLoveWhenRelease = Tween(begin: 68.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconLuvWhenRelease = Tween(begin: 116.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconHahaWhenRelease = Tween(begin: 164.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconWowWhenRelease = Tween(begin: 212.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconSadWhenRelease = Tween(begin: 260.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconAngryWhenRelease = Tween(begin: 308.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));

    zoomIconWhenRelease.addListener(() {
      setState(() {});
    });
    moveUpIconWhenRelease.addListener(() {
      setState(() {});
    });

    moveLeftIconLikeWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconLoveWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconLuvWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconHahaWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconWowWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconSadWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconAngryWhenRelease.addListener(() {
      setState(() {});
    });

    //
    whichIconUserChoose = widget.initReaction;
    if (whichIconUserChoose != 0) {
      animControlIconWhenRelease.reset();
      animControlIconWhenRelease.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    animControlBtnLongPress.dispose();
    animControlBox.dispose();
    animControlIconWhenDrag.dispose();
    animControlIconWhenDragInside.dispose();
    animControlIconWhenDragOutside.dispose();
    animControlBoxWhenDragOutside.dispose();
    animControlIconWhenRelease.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onHorizontalDragEnd: onHorizontalDragEndBoxIcon,
      onHorizontalDragUpdate: onHorizontalDragUpdateBoxIcon,
      child: Container(
        // Area of the content can drag
        // decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        height: 124.0,
        child: Stack(
          children: <Widget>[
            // Box and icons
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                // Box
                renderBox(),

                // Icons
                renderIcons(),
              ],
            ),

            // Button like
            Positioned(
              bottom: 0,
              child: renderBtnLike(),
            ),

            // Icons when jump
            // Icon like
            whichIconUserChoose == 1 && !isDragging
                ? Container(
                    margin: EdgeInsets.only(
                      top: processTopPosition(moveUpIconWhenRelease.value),
                      left: moveLeftIconLikeWhenRelease.value,
                    ),
                    child: Transform.scale(
                      scale: zoomIconWhenRelease.value,
                      child: Image.network(
                        'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),

            // Icon love
            whichIconUserChoose == 2 && !isDragging
                ? Container(
                    margin: EdgeInsets.only(
                      top: processTopPosition(moveUpIconWhenRelease.value),
                      left: moveLeftIconLoveWhenRelease.value,
                    ),
                    child: Transform.scale(
                      scale: zoomIconWhenRelease.value,
                      child: Image.network(
                        'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),

            // Icon Luv
            whichIconUserChoose == 3 && !isDragging
                ? Container(
                    margin: EdgeInsets.only(
                      top: processTopPosition(moveUpIconWhenRelease.value),
                      left: moveLeftIconLuvWhenRelease.value,
                    ),
                    child: Transform.scale(
                      scale: zoomIconWhenRelease.value,
                      child: Image.network(
                        'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),

            // Icon haha
            whichIconUserChoose == 4 && !isDragging
                ? Container(
                    margin: EdgeInsets.only(
                      top: processTopPosition(moveUpIconWhenRelease.value),
                      left: moveLeftIconHahaWhenRelease.value,
                    ),
                    child: Transform.scale(
                      scale: zoomIconWhenRelease.value,
                      child: Image.network(
                        'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),

            // Icon Wow
            whichIconUserChoose == 5 && !isDragging
                ? Container(
                    margin: EdgeInsets.only(
                      top: processTopPosition(moveUpIconWhenRelease.value),
                      left: moveLeftIconWowWhenRelease.value,
                    ),
                    child: Transform.scale(
                      scale: zoomIconWhenRelease.value,
                      child: Image.network(
                        'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),

            // Icon sad
            whichIconUserChoose == 6 && !isDragging
                ? Container(
                    margin: EdgeInsets.only(
                      top: processTopPosition(moveUpIconWhenRelease.value),
                      left: moveLeftIconSadWhenRelease.value,
                    ),
                    child: Transform.scale(
                      scale: zoomIconWhenRelease.value,
                      child: Image.network(
                        'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),

            // Icon angry
            whichIconUserChoose == 7 && !isDragging
                ? Container(
                    margin: EdgeInsets.only(
                      top: processTopPosition(moveUpIconWhenRelease.value),
                      left: moveLeftIconAngryWhenRelease.value,
                    ),
                    child: Transform.scale(
                      scale: zoomIconWhenRelease.value,
                      child: Image.network(
                        'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget renderBox() {
    return Opacity(
      opacity: fadeInBox.value,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey.shade300, width: 0.3),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                // LTRB
                offset: Offset.lerp(
                    const Offset(0.0, 0.0), const Offset(0.0, 0.5), 10.0)!),
          ],
        ),
        width: isDragging ? (previousIconFocus == 0 ? 312.0 : 304.0) : 312.0,
        height: isDragging
            ? (previousIconFocus == 0 ? zoomBoxIcon.value : 40.0)
            : isDraggingOutside
                ? zoomBoxWhenDragOutside.value
                : 50.0,
        margin: const EdgeInsets.only(bottom: 66.0, left: 10.0),
      ),
    );
  }

  Widget renderIcons() {
    return Container(
      width: 308.0,
      height: 124.0,
      margin: EdgeInsets.only(left: moveRightGroupIcon.value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // icon like
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 1
                    ? zoomIconChosen.value
                    : (previousIconFocus == 1
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconLike.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconLikeUp.value),
              width: 40.0,
              height: currentIconFocus == 1 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 1
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const Text(
                            'Thích',
                            style:
                                TextStyle(fontSize: 6.0, color: Colors.white),
                          ),
                        )
                      : Container(),
                  Image.network(
                    'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          // icon love
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 2
                    ? zoomIconChosen.value
                    : (previousIconFocus == 2
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconLove.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconLoveUp.value),
              width: 40.0,
              height: currentIconFocus == 2 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 2
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const Text(
                            'Yêu thích',
                            style:
                                TextStyle(fontSize: 6.0, color: Colors.white),
                          ),
                        )
                      : Container(),
                  Image.network(
                    'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          // icon luv
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 3
                    ? zoomIconChosen.value
                    : (previousIconFocus == 3
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconLuv.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconLuvUp.value),
              width: 40.0,
              height: currentIconFocus == 3 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 3
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const Text(
                            'Thương',
                            style:
                                TextStyle(fontSize: 6.0, color: Colors.white),
                          ),
                        )
                      : Container(),
                  Image.network(
                    'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          // icon haha
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 4
                    ? zoomIconChosen.value
                    : (previousIconFocus == 4
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconHaha.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconHahaUp.value),
              width: 40.0,
              height: currentIconFocus == 4 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 4
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const Text(
                            'Haha',
                            style:
                                TextStyle(fontSize: 6.0, color: Colors.white),
                          ),
                        )
                      : Container(),
                  Image.network(
                    'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          // icon wow
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 5
                    ? zoomIconChosen.value
                    : (previousIconFocus == 5
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconWow.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconWowUp.value),
              width: 40.0,
              height: currentIconFocus == 5 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 5
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const Text(
                            'Wow',
                            style:
                                TextStyle(fontSize: 6.0, color: Colors.white),
                          ),
                        )
                      : Container(),
                  Image.network(
                    'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          // icon sad
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 6
                    ? zoomIconChosen.value
                    : (previousIconFocus == 6
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconSad.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconSadUp.value),
              width: 40.0,
              height: currentIconFocus == 6 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 6
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const Text(
                            'Buồn',
                            style:
                                TextStyle(fontSize: 6.0, color: Colors.white),
                          ),
                        )
                      : Container(),
                  Image.network(
                    'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          // icon angry
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 7
                    ? zoomIconChosen.value
                    : (previousIconFocus == 7
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconAngry.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconAngryUp.value),
              width: 40.0,
              height: currentIconFocus == 7 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 7
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: const Text(
                            'Phẫn nộ',
                            style:
                                TextStyle(fontSize: 6.0, color: Colors.white),
                          ),
                        )
                      : Container(),
                  Image.network(
                    'https://product.hstatic.net/1000367205/product/prevention-_daily_hydrating_moisturizer_spf_30_pdp-r02_6f6414cca7ab4dc9ab03286c48670efe.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // uncomment here to see area of draggable
      // color: Colors.amber.withOpacity(0.5),
    );
  }

  Widget renderBtnLike() {
    return Row(
      children: [
        widget.isReply
            ? SizedBox(
                width: 81.w,
              )
            : SizedBox(
                width: 44.w,
              ),
        SizedBox(
          width: (1.sw / 2) + (widget.isReply ? 44.w : 81.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    widget.timeText,
                    style: textTheme.labelSmall?.copyWith(
                      color: colorBlack.withOpacity(0.5),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: onTapDownBtn,
                    onTapUp: onTapUpBtn,
                    onTap: onTapBtn,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: !isLongPress
                                ? handleOutputRangeZoomInIconLike(
                                    zoomIconLikeInBtn2.value)
                                : zoomTextLikeInBtn.value,
                            child: Text(
                              getTextBtn(),
                              style: textTheme.labelSmall?.copyWith(
                                color: getColorTextBtn(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!widget.isReply) ...[
                    InkWell(
                      onTap: () {
                        widget.onTapReply.call();
                      },
                      child: Text(
                        'Trả lời',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorBlack.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
              InkWell(
                onTap: () {
                  widget.onTapViewReact.call();
                },
                child: Row(
                  children: [
                    _handleIcon(context, widget.reactIcons),
                    if (widget.numReact != 0)
                      Text(
                        widget.numReact.toString(),
                        style: textTheme.labelSmall?.copyWith(
                          color: colorBlack.withOpacity(0.5),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _handleIcon(
    BuildContext context,
    List<int> list,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: list.mapIndexed(
          (i, e) {
            return Align(
              widthFactor: 0.6,
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: 16.r,
                height: 16.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50.r,
                  ),
                  color: colorWhite,
                ),
                padding: EdgeInsets.all(1.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: () {
                    return Image.asset(getIcon(e));
                  }(),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  String getIcon(int value) {
    switch (value) {
      case 1:
        return 'assets/icons/icon_like_fill.png';
      case 2:
        return 'assets/icons/icon_love_2.png';
      case 3:
        return 'assets/icons/icon_luv_luv_2.png';
      case 4:
        return 'assets/icons/icon_haha_2.png';
      case 5:
        return 'assets/icons/icon_wow_2.png';
      case 6:
        return 'assets/icons/icon_sad_2.png';
      case 7:
        return 'assets/icons/icon_angry_2.png';

      default:
        return 'assets/icons/icon_like_2.png';
    }
  }

  String getTextBtn() {
    if (isDragging) {
      return 'Thích';
    }

    switch (whichIconUserChoose) {
      case 1:
        return 'Thích';
      case 2:
        return 'Yêu thích';
      case 3:
        return 'Thương thương';
      case 4:
        return 'Haha';
      case 5:
        return 'Wow';
      case 6:
        return 'Buồn';
      case 7:
        return 'Phẫn nộ';
      default:
        return 'Thích';
    }
  }

  Color getColorTextBtn() {
    if ((!isLongPress && isLiked)) {
      return const Color(0xff3b5998);
    } else if (!isDragging) {
      setState(() {
        isLiked = false;
      });
      switch (whichIconUserChoose) {
        case 1:
          return const Color(0xff3b5998);
        case 2:
          return const Color(0xffED5167);
        case 3:
        case 4:
        case 5:
        case 6:
          return const Color(0xffFFD96A);
        case 7:
          return const Color(0xffF6876B);
        default:
          return colorBlack.withOpacity(0.5);
      }
    } else {
      return colorBlack.withOpacity(0.5);
    }
  }

  String getImageIconBtn() {
    if (!isLongPress && isLiked) {
      return 'assets/icons/icon_like_fill.png';
    } else if (!isDragging) {
      setState(() {
        isLiked = false;
      });
      switch (whichIconUserChoose) {
        case 1:
          return 'assets/icons/icon_like_fill.png';
        case 2:
          return 'assets/icons/icon_love_2.png';
        case 3:
          return 'assets/icons/icon_luv_luv_2.png';
        case 4:
          return 'assets/icons/icon_haha_2.png';
        case 5:
          return 'assets/icons/icon_wow_2.png';
        case 6:
          return 'assets/icons/icon_sad_2.png';
        case 7:
          return 'assets/icons/icon_angry_2.png';

        default:
          return 'assets/icons/icon_like_2.png';
      }
    } else {
      return 'assets/icons/icon_like_2.png';
    }
  }

  Color? getTintColorIconBtn() {
    if (!isLongPress && isLiked) {
      return const Color(0xff3b5998);
    } else if (!isDragging && whichIconUserChoose != 0) {
      setState(() {
        isLiked = false;
      });
      return null;
    } else {
      return Colors.grey;
    }
  }

  double processTopPosition(double value) {
    // margin top 100 -> 40 -> 160 (value from 180 -> 0)
    if (value >= 120.0) {
      return value - 80.0;
    } else {
      return 160.0 - value;
    }
  }

  Color getColorBorderBtn() {
    if ((!isLongPress && isLiked)) {
      return const Color(0xff3b5998);
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return const Color(0xff3b5998);
        case 2:
          return const Color(0xffED5167);
        case 3:
        case 4:
        case 5:
        case 6:
          return const Color(0xffFFD96A);
        case 7:
          return const Color(0xffF6876B);
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey.shade400;
    }
  }

  void onHorizontalDragEndBoxIcon(DragEndDetails dragEndDetail) {
    if (!widget.isOpenBox) return;
    isDragging = false;
    isDraggingOutside = false;
    isJustDragInside = true;
    previousIconFocus = 0;
    currentIconFocus = 0;

    onTapUpBtn(null);
  }

  void onHorizontalDragUpdateBoxIcon(DragUpdateDetails dragUpdateDetail) {
    if (!widget.isOpenBox) return;
    // return if the drag is drag without press button
    if (!isLongPress) return;

    // the margin top the box is 150
    // and plus the height of toolbar and the status bar
    // so the range we check is about 200 -> 500

    if (dragUpdateDetail.globalPosition.dy >= 200 &&
        dragUpdateDetail.globalPosition.dy <= 700) {
      isDragging = true;
      isDraggingOutside = false;

      if (isJustDragInside && !animControlIconWhenDragInside.isAnimating) {
        animControlIconWhenDragInside.reset();
        animControlIconWhenDragInside.forward();
      }

      if (dragUpdateDetail.globalPosition.dx >= 20 &&
          dragUpdateDetail.globalPosition.dx < 80) {
        if (currentIconFocus != 1) {
          handleWhenDragBetweenIcon(1);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 80 &&
          dragUpdateDetail.globalPosition.dx < 120) {
        if (currentIconFocus != 2) {
          handleWhenDragBetweenIcon(2);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 120 &&
          dragUpdateDetail.globalPosition.dx < 160) {
        if (currentIconFocus != 3) {
          handleWhenDragBetweenIcon(3);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 160 &&
          dragUpdateDetail.globalPosition.dx < 200) {
        if (currentIconFocus != 4) {
          handleWhenDragBetweenIcon(4);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 200 &&
          dragUpdateDetail.globalPosition.dx < 240) {
        if (currentIconFocus != 5) {
          handleWhenDragBetweenIcon(5);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 240 &&
          dragUpdateDetail.globalPosition.dx < 280) {
        if (currentIconFocus != 6) {
          handleWhenDragBetweenIcon(6);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 280 &&
          dragUpdateDetail.globalPosition.dx < 320) {
        if (currentIconFocus != 7) {
          handleWhenDragBetweenIcon(7);
        }
      }
    } else {
      whichIconUserChoose = 0;
      previousIconFocus = 0;
      currentIconFocus = 0;
      isJustDragInside = true;

      if (isDragging && !isDraggingOutside) {
        widget.onChangeReaction(0);
        isDragging = false;
        isDraggingOutside = true;
        animControlIconWhenDragOutside.reset();
        animControlIconWhenDragOutside.forward();
        animControlBoxWhenDragOutside.reset();
        animControlBoxWhenDragOutside.forward();
      }
    }
  }

  void handleWhenDragBetweenIcon(int currentIcon) {
    playSound('icon_focus.mp3');
    whichIconUserChoose = currentIcon;
    previousIconFocus = currentIconFocus;
    currentIconFocus = currentIcon;
    animControlIconWhenDrag.reset();
    animControlIconWhenDrag.forward();
  }

  void onTapDownBtn(TapDownDetails tapDownDetail) {
    holdTimer = Timer(durationLongPress, showBox);
  }

  void onTapUpBtn(TapUpDetails? tapUpDetail) {
    if (isLongPress) {
      if (whichIconUserChoose == 0) {
        playSound('box_down.mp3');
      } else {
        playSound('icon_choose.mp3');
      }
    }

    Timer(Duration(milliseconds: durationAnimationBox), () {
      isLongPress = false;
    });

    holdTimer.cancel();

    animControlBtnLongPress.reverse();

    setReverseValue();
    animControlBox.reverse();
    widget.listenBox(false);
    if (whichIconUserChoose != 0) {
      widget.onChangeReaction(whichIconUserChoose);
    }

    animControlIconWhenRelease.reset();
    animControlIconWhenRelease.forward();
  }

  // when user short press the button
  void onTapBtn() {
    if (!isLongPress) {
      if (whichIconUserChoose == 0) {
        isLiked = !isLiked;
      } else {
        whichIconUserChoose = 0;
      }
      if (isLiked) {
        playSound('short_press_like.mp3');
        animControlBtnShortPress.forward();
      } else {
        animControlBtnShortPress.reverse();
      }
      widget.onChangeReaction(isLiked ? 1 : 0);
    }
  }

  double handleOutputRangeZoomInIconLike(double value) {
    if (value >= 0.8) {
      return value;
    } else if (value >= 0.4) {
      return 1.6 - value;
    } else {
      return 0.8 + value;
    }
  }

  double handleOutputRangeTiltIconLike(double value) {
    if (value <= 0.2) {
      return value;
    } else if (value <= 0.6) {
      return 0.4 - value;
    } else {
      return -(0.8 - value);
    }
  }

  void showBox() {
    widget.listenBox(true);
    playSound('box_up.mp3');
    isLongPress = true;

    animControlBtnLongPress.forward();

    setForwardValue();
    animControlBox.forward();
  }

  // We need to set the value for reverse because if not
  // the angry-icon will be pulled down first, not the like-icon
  void setReverseValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );

    pushIconLuvUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );
    zoomIconLuv = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.4)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.4)),
    );
  }

  // When set the reverse value, we need set value to normal for the forward
  void setForwardValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );

    pushIconLuvUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );
    zoomIconLuv = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.6, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.6, 1.0)),
    );
  }

  Future playSound(String nameSound) async {
    // Sometimes multiple sound will play the same time, so we'll stop all before play the newest
    await audioPlayer.stop();
    final file = File('${(await getTemporaryDirectory()).path}/$nameSound');
    await file.writeAsBytes((await loadAsset(nameSound)).buffer.asUint8List());
    // await audioPlayer.play(file.path, isLocal: true);
  }

  Future loadAsset(String nameSound) async {
    return await rootBundle.load('assets/sounds/$nameSound');
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
