import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final String dateStart;
  final String dateEnd;

  CountdownTimer({required this.dateStart, required this.dateEnd});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late String _remainingTime;

  @override
  void initState() {
    super.initState();
    _remainingTime = calculateRemainingTime(widget.dateEnd);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = calculateRemainingTime(widget.dateEnd);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _remainingTime,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: colorWhite,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}

String calculateRemainingTime(String endDate) {
  DateTime now = DateTime.now();
  DateTime end = DateFormat("yyyy-MM-dd HH:mm:ss").parse(endDate);

  Duration difference = end.difference(now);

  if (difference.isNegative) {
    return 'Còn  0d  0h : 0m  :  0s';
  }

  int days = difference.inDays;
  int hours = difference.inHours.remainder(24);
  int minutes = difference.inMinutes.remainder(60);
  int seconds = difference.inSeconds.remainder(60);

  return 'Còn  ${days}d   ${hours}h : ${minutes}m : ${seconds}s';
}
