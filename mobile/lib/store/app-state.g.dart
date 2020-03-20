// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app-state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    auth: json['auth'] == null
        ? null
        : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'auth': instance.auth,
    };
