import 'env_variables_config.dart' as env;
import 'package:flutter/material.dart' show GlobalKey, NavigatorState;
import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;

final apiBase = 'http://${env.emulatorHost}:${env.backendPort}/api/';

@VnumDefinition
class ApiRoute extends Vnum<String> {
  static const ApiRoute token = const ApiRoute.define("token");

  const ApiRoute.define(String fromValue) : super.define(fromValue);
  factory ApiRoute(String value) => Vnum.fromValue(value, ApiRoute);
}
