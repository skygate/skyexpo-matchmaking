import 'package:mobile/common/services/http.service.dart' as api;
import 'package:mobile/config/api.config.dart';

Future<dynamic> getToken(dynamic credentials) {
  return api.post(apiRoutes['token'], credentials);
}
