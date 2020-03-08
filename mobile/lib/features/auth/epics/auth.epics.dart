import 'dart:async';
import 'package:mobile/config/routes.config.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:mobile/features/auth/actions/auth.actions.dart';
import 'package:mobile/features/auth/services/auth.services.dart'
    as authService;
import 'package:mobile/store/app-state.dart';

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

final logInTypedEpic = new TypedEpic<AppState, LogInRequestAction>(logInEpic);

final authEpics = combineEpics<AppState>([logInTypedEpic]);
