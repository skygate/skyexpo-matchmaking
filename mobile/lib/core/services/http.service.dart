import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' show Response;
import 'package:flipperkit_http_interceptor/flipperkit_http_interceptor.dart'
    show HttpClientWithInterceptor;

class HttpService {
  final String apiUrl;
  final HttpClientWithInterceptor http;

  HttpService(this.apiUrl, this.http);

  get(String path) async {
    final response = await http.get(apiUrl + path + '/');

    return response.body;
  }

  post(String path, body) async {
    final Response response = await http.post(apiUrl + path + '/',
        body: json.encode(body.toJson()),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode != 200 || response.statusCode != 201) {
      throw (response);
    }
    return response.body;
  }
}
