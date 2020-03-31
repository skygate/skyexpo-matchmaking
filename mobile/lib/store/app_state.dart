import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

import 'package:mobile/features/auth/reducers/auth_reducer.dart'
    show AuthState, authReducer;
import 'package:mobile/features/matching/reducers/matching_reducer.dart'
    show MatchingState, matchingReducer;

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  final AuthState auth;
  final MatchingState matching;

  AppState({this.auth, this.matching});

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

AppState appReducer(AppState state, action) {
  return AppState(
      auth: authReducer(state.auth, action),
      matching: matchingReducer(state.matching, action));
}
