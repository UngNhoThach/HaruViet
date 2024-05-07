import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListProfileSection {
  String title;
  Widget icon;
  Color color;
  void Function() onTap;
  ListProfileSection(this.title, this.icon, this.color, this.onTap);
}
