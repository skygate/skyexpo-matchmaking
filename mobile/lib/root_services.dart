import 'package:flipperkit_http_interceptor/flipperkit_http_interceptor.dart'
    show HttpClientWithInterceptor;

import 'package:mobile/config/api.config.dart' as api_config;

import 'package:mobile/core/services/http.service.dart' show HttpService;
import 'features/auth/services/auth_service.dart' show AuthService;

final http = HttpClientWithInterceptor();

final httpService = HttpService(api_config.apiBase, http);
final authService = AuthService(httpService);
