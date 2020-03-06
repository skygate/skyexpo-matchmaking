import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mobile/config/api.config.dart' as apiConfig;

get(String path) async {
  var response = await http.get(apiConfig.apiBase + path + '/');

  return response.body;
}

post(String path, body) async {
  var response = await http.post(apiConfig.apiBase + path + '/',
      body: json.encode(body),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  print(response);

  return response.body;
}
