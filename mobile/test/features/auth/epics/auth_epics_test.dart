import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:mobile/features/auth/actions/auth_actions.dart'
    show
        LogInFailedAction,
        LogInRequestAction,
        LogInSucceedAction,
        RegisterFailedAction,
        RegisterRequestAction,
        RegisterSucceedAction;
import 'package:mobile/features/auth/epics/auth_epics.dart'
    show authEpicsFactory;
import 'package:mobile/features/auth/services/auth_service.dart'
    show AuthService;

import '../../../test_utills/epics_test_utils.dart'
    show testActionReducer, testRedirect;
import '../mocks/auth_mocks.dart'
    show credentailsMock, registerRequestMock, userMock;

class AuthServiceMock extends Mock implements AuthService {}

void main() {
  group('Auth epics', () {
    AuthServiceMock authService;
    dynamic authEpics;
    EpicMiddleware<String> epicMiddleware;
    Store<String> store;

    setUp(() {
      authService = AuthServiceMock();
      authEpics = authEpicsFactory<String>(authService, testRedirect);
      epicMiddleware = EpicMiddleware<String>(authEpics);
      store = Store<String>(
        testActionReducer,
        middleware: [epicMiddleware],
      );
    });

    group('logInEpic', () {
      test('Should call AuthService and return success action', () async {
        when(authService.getToken(credentials: credentailsMock))
            .thenAnswer((_) async => Future.value(userMock));

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
        when(authService.getToken(credentials: credentailsMock))
            .thenAnswer((_) async => Future.error('error'));

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
    group('registerEpic', () {
      test('Should call AuthService and return success action', () async {
        when(authService.register(registerRequest: registerRequestMock))
            .thenAnswer((_) async => Future.value(userMock));

        scheduleMicrotask(() {
          store.dispatch(RegisterRequestAction(registerRequestMock));
        });

        expect(
            store.onChange,
            emitsInAnyOrder([
              RegisterRequestAction(registerRequestMock).toString(),
              [
                RegisterSucceedAction(userMock).toString(),
                LogInRequestAction(credentailsMock).toString()
              ].toString()
            ]));
      });

      test('Should call AuthService and return success action', () async {
        when(authService.register(registerRequest: registerRequestMock))
            .thenAnswer((_) async => Future.error('error'));

        scheduleMicrotask(() {
          store.dispatch(RegisterRequestAction(registerRequestMock));
        });

        expect(
            store.onChange,
            emitsInAnyOrder(<String>[
              RegisterRequestAction(registerRequestMock).toString(),
              RegisterFailedAction().toString()
            ]));
      });
    });
  });
}
