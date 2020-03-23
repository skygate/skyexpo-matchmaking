import 'package:mockito/mockito.dart';

String testActionReducer(String state, dynamic action) => action.toString();

//Mockito can only mock classes, I can spy on this method
class RedirectMock extends Mock {
  redirect(String route) {}
}
