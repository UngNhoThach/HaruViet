import 'package:flutter/material.dart';

/// Dùng class này khi muốn text field không bị focus khi bấm vào
/// Ví dụ: show date picker khi bấm vào TextField
/// Use:
/// TextField(focusNode: AlwaysDisabledFocusNode());
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
