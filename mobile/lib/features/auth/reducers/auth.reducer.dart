import 'package:redux/redux.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mobile/features/auth/actions/auth.actions.dart';

part 'auth.reducer.g.dart';

@JsonSerializable()
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

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
}

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LogInSucceedAction>(getTokenSucceedReducer),
  TypedReducer<AuthState, LogInFailedAction>(getTokenFailedReducer),
]);

AuthState getTokenSucceedReducer(
    AuthState authState, LogInSucceedAction action) {
  return new AuthState(
      email: action.user.email,
      token: action.user.token,
      isAuthenticated: true,
      authIsChecked: authState.authIsChecked);
}

AuthState getTokenFailedReducer(AuthState authState, LogInFailedAction action) {
  return new AuthState(
      email: 'testemail',
      token: authState.token,
      isAuthenticated: false,
      authIsChecked: true);
}
