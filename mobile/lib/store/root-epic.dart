import 'package:mobile/features/auth/epics/auth.epics.dart';
import 'package:redux_epics/redux_epics.dart';

var epicMiddleware = new EpicMiddleware(authEpics);
