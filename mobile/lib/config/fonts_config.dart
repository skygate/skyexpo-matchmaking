import 'package:flutter/material.dart' show GlobalKey, NavigatorState;
import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@VnumDefinition
class FontSize extends Vnum<double> {
  static const FontSize small = const FontSize.define(14);
  static const FontSize normal = const FontSize.define(16);
  static const FontSize big = const FontSize.define(24);
  static const FontSize veryBig = const FontSize.define(32);

  const FontSize.define(double fromValue) : super.define(fromValue);
  factory FontSize(double value) => Vnum.fromValue(value, FontSize);
}
