import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as dart_http;
import 'package:flipperkit_http_interceptor/flipperkit_http_interceptor.dart'
    as interceptor;

import 'package:mobile/config/api.config.dart' as api_config;

final http = new interceptor.HttpClientWithInterceptor();

get(String path) async {
  final response = await http.get(api_config.apiBase + path + '/');

  return response.body;
}

post(String path, body) async {
  final dart_http.Response response = await http.post(
      api_config.apiBase + path + '/',
      body: json.encode(body.toJson()),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  if (response.statusCode != 200 || response.statusCode != 201) {
    throw (response);
  }
  return response.body;
}
