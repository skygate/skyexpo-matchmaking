import 'package:flutter/material.dart' show Color;
import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;

@VnumDefinition
class AppColor extends Vnum<Color> {
  static const AppColor background = const AppColor.define(Color(0xFFF3F5FA));
  static const AppColor primary = const AppColor.define(Color(0xFF000A64));

  const AppColor.define(Color fromValue) : super.define(fromValue);
  factory AppColor(int value) => Vnum.fromValue(Color(value), AppColor);
}
