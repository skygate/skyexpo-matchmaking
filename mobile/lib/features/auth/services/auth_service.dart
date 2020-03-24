import 'dart:convert' show json;

import 'package:mobile/config/api_config.dart' show ApiRoute;
import 'package:mobile/core/services/http_service.dart' show HttpService;
import 'package:mobile/features/auth/models/credentails_model.dart'
    show Credentials;
import 'package:mobile/features/auth/models/user_model.dart' show User;

class AuthService {
  final HttpService http;

  AuthService(this.http);

  Future<User> getToken({Credentials credentials}) async {
    final String response =
        await http.post(path: ApiRoute.token.value, body: credentials);

    return User.fromJson(json.decode(response));
  }
}
