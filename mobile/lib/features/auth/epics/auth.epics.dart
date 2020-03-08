import 'dart:async';
import 'package:mobile/config/routes.config.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:mobile/features/auth/actions/auth.actions.dart';
import 'package:mobile/features/auth/services/auth.services.dart'
    as authService;
import 'package:mobile/store/app-state.dart';

Stream<dynamic> logInEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is LogInRequestAction).asyncMap(
      (action) => authService.getToken(action.credentials).then((results) {
            return LogInSucceedAction(results);
          }, onError: (error) {
            navigatorKey.currentState.pushNamed(routes["afterAuth"]);
            return LogInFailedAction();
          }));
}

final authEpics = combineEpics<AppState>([logInEpic]);
