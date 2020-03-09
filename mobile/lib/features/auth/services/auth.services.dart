import 'package:mobile/core/services/http.service.dart' as api;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile/config/api.config.dart';
import 'package:mobile/features/auth/models/credentails.model.dart';
import 'package:mobile/features/auth/models/user.model.dart';

Future<User> getToken(Credentials credentials) async {
  final http.Response response =
      await api.post(apiRoutes['token'], credentials);
  return User.fromJson(json.decode(response.body));
}
