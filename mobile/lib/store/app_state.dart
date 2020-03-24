import 'package:json_annotation/json_annotation.dart';

import 'package:mobile/features/auth/reducers/auth_reducer.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  AppState({this.auth});
  final AuthState auth;

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

AppState appReducer(AppState state, action) {
  return AppState(
    auth: authReducer(state.auth, action),
  );
}
