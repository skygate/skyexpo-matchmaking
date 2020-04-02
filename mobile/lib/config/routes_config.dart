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
  static const AppRoute profileForm = const AppRoute.define("profile-form");
  static const AppRoute bottomNavigation =
      const AppRoute.define("bottom-navigation");

  const AppRoute.define(String fromValue) : super.define(fromValue);
  factory AppRoute(String value) => Vnum.fromValue(value, AppRoute);
}

@VnumDefinition
class BottomNavigationRoute extends Vnum<String> {
  static const BottomNavigationRoute matchingList =
      const BottomNavigationRoute.define("matching-list");
  static const BottomNavigationRoute calendar =
      const BottomNavigationRoute.define("calendar");
  static const BottomNavigationRoute notifications =
      const BottomNavigationRoute.define("notifications");
  static const BottomNavigationRoute settings =
      const BottomNavigationRoute.define("settings");

  const BottomNavigationRoute.define(String fromValue)
      : super.define(fromValue);
  factory BottomNavigationRoute(String value) =>
      Vnum.fromValue(value, BottomNavigationRoute);
}
