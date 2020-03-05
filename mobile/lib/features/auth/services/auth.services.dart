import 'package:mobile/common/services/http.service.dart' as api;
import 'package:mobile/config/api.config.dart';
import 'package:mobile/features/auth/models/credentails.model.dart';

Future<Credentials> getToken(Credentials credentials) async {
  return await api.post(apiRoutes['token'], credentials);
}
