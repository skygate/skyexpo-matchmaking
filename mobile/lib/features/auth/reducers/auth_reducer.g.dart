// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_reducer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) {
  return AuthState(
    email: json['email'] as String,
    token: json['token'] as String,
    isAuthenticated: json['isAuthenticated'] as bool,
    authIsChecked: json['authIsChecked'] as bool,
  );
}

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'email': instance.email,
      'token': instance.token,
      'isAuthenticated': instance.isAuthenticated,
      'authIsChecked': instance.authIsChecked,
    };
