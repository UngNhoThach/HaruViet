import 'package:flutter/material.dart';

class ScollToHideBottomBar extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScollToHideBottomBar({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<ScollToHideBottomBar> createState() => _ScollToHideBottomBarState();
}

class _ScollToHideBottomBarState extends State<ScollToHideBottomBar> {
  bool isVisible = false;
  bool isClicked = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    if (isClicked) {
      // Nếu người dùng đã click, không làm gì cả
      return;
    }

    if (widget.controller.position.pixels >
        MediaQuery.of(context).size.height * 0.75) {
      showBottomBar();
    } else {
      hideBottomBar();
    }
  }

  void showBottomBar() {
    if (!isVisible) {
      setState(() => isVisible = true);
    }
  }

  void hideBottomBar() {
    if (isVisible) {
      setState(() => isVisible = false);
    }
  }

  void handleClick() {
    isClicked = true;
    if (isVisible) {
      hideBottomBar();
    } else {
      showBottomBar();
    }

    Future.delayed(widget.duration, () {
      setState(() => isClicked = false);
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        // final height = MediaQuery.of(context).size.height * 0.35,

        onTap: handleClick,
        child: AnimatedContainer(
          duration: widget.duration,
          height: isVisible ? kBottomNavigationBarHeight : 0,
          child: Wrap(
            children: [
              widget.child,
            ],
          ),
        ),
      );
}
