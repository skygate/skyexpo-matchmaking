import 'dart:async';
import 'package:redux_epics/redux_epics.dart' show EpicStore, combineEpics;
import 'package:rxdart/rxdart.dart';

import 'package:mobile/config/routes_config.dart' show AppRoute, Redirect;
import '../services/auth_service.dart' show AuthService;
import '../models/index.dart' show Credentials;
import '../actions/auth_actions.dart'
    show
        LogInRequestAction,
        LogInSucceedAction,
        LogInFailedAction,
        RegisterRequestAction,
        RegisterSucceedAction,
        RegisterFailedAction;

authEpicsFactory<T>(AuthService authService, Redirect redirect) {
  Stream<dynamic> logInEpic(Stream<dynamic> actions, EpicStore<T> store) {
    return actions.whereType<LogInRequestAction>().asyncMap((action) =>
        authService
            .getToken(credentials: action.credentials)
            .then((user) => LogInSucceedAction(user), onError: (error) {
          //For POC I redirect from here because I can't create account on backend and always get 401
          redirect(AppRoute.afterAuth);

          return LogInFailedAction();
        }));
  }

  Stream<dynamic> registerEpic(Stream<dynamic> actions, EpicStore<T> store) {
    return actions.whereType<RegisterRequestAction>().asyncMap((action) =>
        authService.register(registerRequest: action.registerRequest).then(
            (user) {
          redirect(AppRoute.afterAuth);
          final registerRequest = action.registerRequest;
          final credentials = Credentials(
              email: registerRequest.email, password: registerRequest.password);

          return [RegisterSucceedAction(user), LogInRequestAction(credentials)];
        }, onError: (error) => RegisterFailedAction()));
  }

  return combineEpics<T>([logInEpic, registerEpic]);
}
