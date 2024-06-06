import 'package:eco_app/helper/colors.dart';
import 'package:flutter/material.dart';

class FlashDealsTimer extends StatelessWidget {
  const FlashDealsTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black, // Màu nền là màu đen
        borderRadius: BorderRadius.circular(8.0),
      ),
      // padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<Duration>(
              duration: const Duration(hours: 2),
              tween: Tween(begin: const Duration(hours: 2), end: Duration.zero),
              onEnd: () {
                // bloc.onChangeTimeUp(true);
              },
              builder: (BuildContext context, Duration value, Widget? child) {
                final hours = value.inHours.toString().padLeft(2, '0');
                final minutes =
                    (value.inMinutes % 60).toString().padLeft(2, '0');
                final seconds =
                    (value.inSeconds % 60).toString().padLeft(2, '0');
                return Row(
                  children: [
                    _buildTimerFrame(
                      hours,
                    ),
                    const SizedBox(width: 8.0),
                    _buildTimerFrame(
                      minutes,
                    ),
                    const SizedBox(width: 8.0),
                    _buildTimerFrame(
                      seconds,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildTimerFrame(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorBlack,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: colorWhite,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
