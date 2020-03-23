import 'dart:async';
import 'package:redux_epics/redux_epics.dart' show EpicStore, combineEpics;
import 'package:rxdart/rxdart.dart';

import 'package:mobile/config/routes_config.dart' show AppRoute;
import 'package:mobile/features/auth/services/auth_service.dart'
    show AuthService;
import 'package:mobile/features/auth/actions/auth.actions.dart';

authEpicsFactory<T>(AuthService authService, dynamic redirect) {
  Stream<dynamic> logInEpic(Stream<dynamic> actions, EpicStore<T> store) {
    return actions.whereType<LogInRequestAction>().asyncMap((action) =>
        authService
            .getToken(credentials: action.credentials)
            .then((results) => LogInSucceedAction(results), onError: (error) {
          //For POC I redirect from here because I can't create account on backend and always get 401
          redirect(AppRoute.afterAuth.value);

          return LogInFailedAction();
        }));
  }

  return combineEpics<T>([logInEpic]);
}