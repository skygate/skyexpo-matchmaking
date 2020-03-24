import 'package:redux/redux.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mobile/features/auth/actions/auth_actions.dart' as actions;

part 'auth_reducer.g.dart';

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
  TypedReducer<AuthState, actions.LogInSucceedAction>(getTokenSucceedReducer),
  TypedReducer<AuthState, actions.LogInFailedAction>(getTokenFailedReducer),
]);

AuthState getTokenSucceedReducer(
    AuthState authState, actions.LogInSucceedAction action) {
  return AuthState(
      email: action.user.email,
      token: action.user.token,
      isAuthenticated: true,
      authIsChecked: authState.authIsChecked);
}

AuthState getTokenFailedReducer(
    AuthState authState, actions.LogInFailedAction action) {
  return AuthState(
      email: 'testemail',
      token: authState.token,
      isAuthenticated: false,
      authIsChecked: true);
}
