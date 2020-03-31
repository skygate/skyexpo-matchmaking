// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    auth: json['auth'] == null
        ? null
        : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
    matching: json['matching'] == null
        ? null
        : MatchingState.fromJson(json['matching'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'auth': instance.auth,
      'matching': instance.matching,
    };
