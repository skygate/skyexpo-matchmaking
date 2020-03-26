import 'env_variables_config.dart' as env;
import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;

final apiBase = 'http://${env.emulatorHost}:${env.backendPort}/api/';

@VnumDefinition
class ApiRoute extends Vnum<String> {
  static const ApiRoute token = const ApiRoute.define("token");
  static const ApiRoute refreshToken = const ApiRoute.define("token/refresh");
  static const ApiRoute register = const ApiRoute.define("profiles");

  const ApiRoute.define(String fromValue) : super.define(fromValue);
  factory ApiRoute(String value) => Vnum.fromValue(value, ApiRoute);
}
