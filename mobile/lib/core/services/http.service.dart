import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mobile/config/api.config.dart' as apiConfig;

get(String path) async {
  final response = await http.get(apiConfig.apiBase + path + '/');

  return response.body;
}

post(String path, body) async {
  final http.Response response = await http.post(apiConfig.apiBase + path + '/',
      body: json.encode(body.toJson()),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  if (response.statusCode != 200 || response.statusCode != 201) {
    throw (response);
  }
  return response.body;
}