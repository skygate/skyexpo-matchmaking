import 'package:flutter/material.dart' show GlobalKey, NavigatorState;
import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

redirect(AppRoute route) {
  navigatorKey.currentState.pushNamed(route.value);
}

typedef void Redirect(AppRoute route);

@VnumDefinition
class AppRoute extends Vnum<String> {
  static const AppRoute home = const AppRoute.define("/");
  static const AppRoute logIn = const AppRoute.define("log-in");
  static const AppRoute register = const AppRoute.define("register");
  static const AppRoute afterAuth = const AppRoute.define("after-auth");
  static const AppRoute matchingList = const AppRoute.define("matching-list");
  static const AppRoute calendar = const AppRoute.define("calendar");
  static const AppRoute notifications = const AppRoute.define("notifications");
  static const AppRoute settings = const AppRoute.define("settings");

  const AppRoute.define(String fromValue) : super.define(fromValue);
  factory AppRoute(String value) => Vnum.fromValue(value, AppRoute);
}
