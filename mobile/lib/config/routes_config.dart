import 'package:flutter/material.dart' show GlobalKey, NavigatorState;
import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@VnumDefinition
class AppRoute extends Vnum<String> {
  static const AppRoute home = const AppRoute.define("/");
  static const AppRoute logIn = const AppRoute.define("log-in");
  static const AppRoute afterAuth = const AppRoute.define("after-auth");
  static const AppRoute matchingList = const AppRoute.define("matching-list");

  const AppRoute.define(String fromValue) : super.define(fromValue);
  factory AppRoute(String value) => Vnum.fromValue(value, AppRoute);
}
