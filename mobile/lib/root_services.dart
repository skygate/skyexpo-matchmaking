import 'package:flipperkit_http_interceptor/flipperkit_http_interceptor.dart'
    show HttpClientWithInterceptor;

import 'package:mobile/config/api_config.dart' show apiBase;

import 'package:mobile/core/services/http_service.dart' show HttpService;
import 'features/auth/services/auth_service.dart' show AuthService;

final http = HttpClientWithInterceptor();

final httpService = HttpService(apiBase, http);
final authService = AuthService(httpService);
