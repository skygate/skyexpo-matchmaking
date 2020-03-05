import 'package:mobile/features/auth/reducers/auth.reducer.dart';

class AppState {
  AppState({this.auth}) {}
  final AuthState auth;
}

AppState appReducer(AppState state, action) {
  return AppState(
    auth: authReducer(state.auth, action),
  );
}
