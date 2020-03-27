import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' show Mock, when;

import 'package:mobile/config/api_config.dart' show ApiRoute;
import 'package:mobile/core/services/http_service.dart' show HttpService;
import 'package:mobile/features/auth/services/auth_service.dart'
    show AuthService;

import '../mocks/auth_mocks.dart'
    show credentailsMock, registerRequestMock, userMock, userResponseMock;

class HttpMock extends Mock implements HttpService {}

void main() {
  group('Auth services', () {
    HttpMock http;
    AuthService authService;
    setUp(() {
      http = HttpMock();
      authService = AuthService(http);
    });
    group('getToken service', () {
      test('should call http service with credentials and return user',
          () async {
        when(http.post(path: ApiRoute.token.value, body: credentailsMock))
            .thenAnswer((_) async => Future.value(userResponseMock));

        final response =
            await authService.getToken(credentials: credentailsMock);

        expect(userMock == response, equals(true));
      });

      test('should call http service with credentials and return Error',
          () async {
        when(http.post(path: ApiRoute.token.value, body: credentailsMock))
            .thenThrow(Exception('Failed to connect'));

        expect(authService.getToken(credentials: credentailsMock),
            throwsException);
      });
    });
    group('register service', () {
      test('should call http service with registerRequest and return user',
          () async {
        when(http.post(
                path: ApiRoute.register.value, body: registerRequestMock))
            .thenAnswer((_) async => Future.value(userResponseMock));

        final response =
            await authService.register(registerRequest: registerRequestMock);

        expect(userMock == response, equals(true));
      });

      test('should call http service with registerRequest and return Error',
          () async {
        when(http.post(
                path: ApiRoute.register.value, body: registerRequestMock))
            .thenThrow(Exception('Failed to connect'));

        expect(authService.register(registerRequest: registerRequestMock),
            throwsException);
      });
    });
  });
}
