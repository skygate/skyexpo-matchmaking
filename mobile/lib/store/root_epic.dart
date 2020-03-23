import 'package:redux_epics/redux_epics.dart' show EpicMiddleware;

import 'package:mobile/features/auth/epics/auth_epics.dart'
    show authEpicsFactory;
import 'package:mobile/root_services.dart' show authService;
import 'package:mobile/store/app_state.dart' show AppState;
import 'package:mobile/config/routes_config.dart' show navigatorKey;

final authEpics = authEpicsFactory<AppState>(
    authService, navigatorKey.currentState.pushNamed);

final epicMiddleware = EpicMiddleware<AppState>(authEpics as dynamic);
