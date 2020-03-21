import 'package:flutter/material.dart' show GlobalKey, NavigatorState;
import 'package:built_value/built_value.dart' show EnumClass;
import 'package:built_collection/built_collection.dart' show BuiltSet;

part 'routes_config.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Route extends EnumClass {
  static const Route home = _$home;
  static const Route logIn = _$logIn;
  static const Route afterAuth = _$afterAuth;
  static const Route matchingList = _$matchingList;

  const Route._(String name) : super(name);

  static BuiltSet<Route> get values => _$values;
  static Route valueOf(String name) => _$valueOf(name);
}
