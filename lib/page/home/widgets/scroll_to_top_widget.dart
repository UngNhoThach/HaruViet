import 'package:flutter/material.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController scrollController;
  final Color backgroundColor;
  final Color iconColor;
  final double showOffset; // How far scroll before the button shows up

  const ScrollToTopButton({
    Key? key,
    required this.scrollController,
    this.backgroundColor = Colors.black45,
    this.iconColor = Colors.white,
    this.showOffset = 100, // Default to show after scrolling 100 pixels
  }) : super(key: key);

  @override
  _ScrollToTopButtonState createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (widget.scrollController.offset >= widget.showOffset) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    } else {
      if (_isVisible) {
        setState(() {
          _isVisible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isVisible,
      child: FloatingActionButton(
        onPressed: () => widget.scrollController.animateTo(
          0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        ),
        backgroundColor: widget.backgroundColor,
        child: Icon(
          Icons.arrow_upward,
          color: widget.iconColor,
        ),
      ),
    );
  }
}
