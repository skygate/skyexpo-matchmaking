import 'package:mobile/config/routes_config.dart' show AppRoute;
import 'package:mockito/mockito.dart';

String testActionReducer(String state, dynamic action) => action.toString();

//Mockito can only mock classes, I can spy on this method
testRedirect(AppRoute route) {}
