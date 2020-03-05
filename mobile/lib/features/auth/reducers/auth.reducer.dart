import 'package:redux/redux.dart';

import 'package:mobile/features/auth/actions/auth.actions.dart';

class AuthState {
  AuthState(
      {this.email = '',
      this.token = '',
      this.isAuthenticated = false,
      this.authIsChecked = false});

  final String email;
  final String token;
  final bool isAuthenticated;
  final bool authIsChecked;
}

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LogInSucceedAction>(getTokenSucceedReducer),
]);

AuthState getTokenSucceedReducer(
    AuthState authState, LogInSucceedAction action) {
  return new AuthState(
      email: action.userData.email,
      token: 'token',
      isAuthenticated: true,
      authIsChecked: authState.authIsChecked);
}
