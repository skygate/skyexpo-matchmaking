import 'package:flutter/material.dart' show Color;
import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;

@VnumDefinition
class AppColor extends Vnum<Color> {
  static const AppColor background = const AppColor.define(Color(0xFFF3F5FA));
  static const AppColor elementsBackground =
      const AppColor.define(Color(0xFFFFFFFF));
  static const AppColor primary = const AppColor.define(Color(0xFF000A64));
  static const AppColor inputBackground =
      const AppColor.define(Color(0xFFF5F5F5));
  static const AppColor buttonBackground =
      const AppColor.define(Color(0xFF656565));
  static const AppColor buttonText = const AppColor.define(Color(0xFFFFFFFF));
  static const AppColor divider = const AppColor.define(Color(0xFFD9D9D9));
  static const AppColor icon = const AppColor.define(Color(0xFFB2B2B2));

  const AppColor.define(Color fromValue) : super.define(fromValue);
  factory AppColor(int value) => Vnum.fromValue(Color(value), AppColor);
}
