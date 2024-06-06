import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListProfileSection {
  final String title;
  final Widget icon;
  final Color color;

  final void Function() onTap;
  ListProfileSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
