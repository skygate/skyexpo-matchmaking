import 'dart:async';
import 'package:redux_epics/redux_epics.dart'
    show EpicStore, TypedEpic, combineEpics;

import 'package:mobile/config/routes.config.dart' show navigatorKey, routes;
import 'package:mobile/features/auth/services/auth_service.dart'
    show AuthService;
import 'package:mobile/features/auth/actions/auth.actions.dart';
import 'package:mobile/store/app_state.dart' show AppState;

authEpicsFactory(AuthService authService) {
  Stream<dynamic> logInEpic(
      Stream<LogInRequestAction> actions, EpicStore<AppState> store) {
    return actions.where((action) => action is LogInRequestAction).asyncMap(
        (action) => authService.getToken(action.credentials).then((results) {
              return LogInSucceedAction(results);
            }, onError: (error) {
              //For POC I redirect from here because I can't create account on backend and always get 401
              navigatorKey.currentState.pushNamed(routes["afterAuth"]);

              return LogInFailedAction();
            }));
  }

  final logInTypedEpic = TypedEpic<AppState, LogInRequestAction>(logInEpic);

  return combineEpics<AppState>([logInTypedEpic]);
}
