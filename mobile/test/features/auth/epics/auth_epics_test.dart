import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:mobile/features/auth/actions/auth_actions.dart'
    show LogInRequestAction, LogInSucceedAction, LogInFailedAction;
import 'package:mobile/features/auth/epics/auth_epics.dart'
    show authEpicsFactory;
import 'package:mobile/features/auth/services/auth_service.dart'
    show AuthService;

import '../../../test_utills/epics_test_utils.dart'
    show testActionReducer, testRedirect;
import '../mocks/user_mock.dart' show userMock, credentailsMock;

class AuthServiceMock extends Mock implements AuthService {}

void main() {
  group('Auth Epic', () {
    AuthServiceMock authService;

    tearDown(() {
      authService = AuthServiceMock();
    });

    test('Should call AuthService and return success action', () async {
      authService = AuthServiceMock();

      when(authService.getToken(credentials: credentailsMock))
          .thenAnswer((_) async => Future.value(userMock));

      final authEpics = authEpicsFactory<String>(authService, testRedirect);

      final epicMiddleware = EpicMiddleware<String>(authEpics);
      final store = Store<String>(
        testActionReducer,
        middleware: [epicMiddleware],
      );

      scheduleMicrotask(() {
        store.dispatch(LogInRequestAction(credentailsMock));
      });

      expect(
          store.onChange,
          emitsInAnyOrder(<String>[
            LogInRequestAction(credentailsMock).toString(),
            LogInSucceedAction(userMock).toString()
          ]));
    });

    test('Should call AuthService and return success action', () async {
      authService = AuthServiceMock();

      when(authService.getToken(credentials: credentailsMock))
          .thenAnswer((_) async => Future.error('error'));

      final authEpics = authEpicsFactory<String>(authService, testRedirect);

      final epicMiddleware = EpicMiddleware<String>(authEpics);
      final store = Store<String>(
        testActionReducer,
        middleware: [epicMiddleware],
      );

      scheduleMicrotask(() {
        store.dispatch(LogInRequestAction(credentailsMock));
      });

      expect(
          store.onChange,
          emitsInAnyOrder(<String>[
            LogInRequestAction(credentailsMock).toString(),
            LogInFailedAction().toString()
          ]));
    });
  });
}
