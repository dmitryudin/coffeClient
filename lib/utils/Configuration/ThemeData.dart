import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeDatas {
  static final ThemeDatas _ThemeData = ThemeDatas._instance();

  factory ThemeDatas() {
    return _ThemeData;
  }
  ThemeDatas._instance();

  TextStyle text1Style = TextStyle(fontSize: 36);
}
