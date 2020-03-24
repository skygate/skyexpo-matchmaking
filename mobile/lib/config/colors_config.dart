import 'package:flutter/material.dart' show Color;
import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;

@VnumDefinition
class AppColor extends Vnum<Color> {
  static const AppColor background = const AppColor.define(Color(0xFFFFFFFF));
  static const AppColor primary = const AppColor.define(Color(0xFF000A64));
  static const AppColor iputBackground =
      const AppColor.define(Color(0xFFF5F5F5));

  const AppColor.define(Color fromValue) : super.define(fromValue);
  factory AppColor(int value) => Vnum.fromValue(Color(value), AppColor);
}
