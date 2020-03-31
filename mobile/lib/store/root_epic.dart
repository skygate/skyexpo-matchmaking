import 'package:mobile/features/matching/epics/matching_epics.dart';
import 'package:redux_epics/redux_epics.dart' show EpicMiddleware, combineEpics;

import 'package:mobile/features/auth/epics/auth_epics.dart'
    show authEpicsFactory;
import 'package:mobile/root_services.dart' show authService, matchingService;
import 'package:mobile/store/app_state.dart' show AppState;
import 'package:mobile/config/routes_config.dart' show redirect;

final authEpics = authEpicsFactory<AppState>(authService, redirect);
final matchingEpics = matchigEpicsFactory<AppState>(matchingService);

final combinedEpics = combineEpics<AppState>([authEpics, matchingEpics]);

final epicMiddleware = EpicMiddleware<AppState>(combinedEpics);
