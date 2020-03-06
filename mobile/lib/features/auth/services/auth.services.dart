import 'package:mobile/common/services/http.service.dart' as api;
import 'package:mobile/config/api.config.dart';
import 'package:mobile/features/auth/models/credentails.model.dart';

Future<dynamic> getToken(dynamic credentials) async {
  print(credentials);
  return api.post(apiRoutes['token'],
      {"email": "lubieplacki@gmail.com", "password": "sdfsd3jhdf"});
}
