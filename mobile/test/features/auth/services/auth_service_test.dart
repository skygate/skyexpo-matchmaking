import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' show Mock, when;

import 'package:mobile/config/api_config.dart' show ApiRoute;
import 'package:mobile/core/services/http_service.dart' show HttpService;
import 'package:mobile/features/auth/services/auth_service.dart'
    show AuthService;

import '../mocks/user_mock.dart'
    show userMock, userResponseMock, credentailsMock;

class HttpMock extends Mock implements HttpService {}

void main() {
  group('Auth service', () {
    test('should call http service with credentials and return user', () async {
      final http = HttpMock();

      when(http.post(path: ApiRoute.token.value, body: credentailsMock))
          .thenAnswer((_) async => Future.value(userResponseMock));

      final authService = AuthService(http);
      final response = await authService.getToken(credentials: credentailsMock);

      expect(userMock == response, equals(true));
    });

    test('should call http service with credentials and return Error',
        () async {
      final http = HttpMock();

      when(http.post(path: ApiRoute.token.value, body: credentailsMock))
          .thenThrow(Exception('Failed to connect'));

      final authService = AuthService(http);

      expect(
          authService.getToken(credentials: credentailsMock), throwsException);
    });
  });
}
