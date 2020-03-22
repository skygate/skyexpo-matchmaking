import 'package:http/http.dart' show Response;
import 'dart:convert' show json;

import 'package:mobile/config/api.config.dart' show ApiRoute;
import 'package:mobile/core/services/http.service.dart' show HttpService;
import 'package:mobile/features/auth/models/credentails.model.dart'
    show Credentials;
import 'package:mobile/features/auth/models/user.model.dart' show User;

class AuthService {
  final HttpService http;

  AuthService(this.http);

  Future<User> getToken(Credentials credentials) async {
    final Response response =
        await http.post(ApiRoute.token.value, credentials);

    return User.fromJson(json.decode(response.body));
  }
}
