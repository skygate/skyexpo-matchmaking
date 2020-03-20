// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInRequestAction _$LogInRequestActionFromJson(Map<String, dynamic> json) {
  return LogInRequestAction(
    json['credentials'] == null
        ? null
        : Credentials.fromJson(json['credentials'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LogInRequestActionToJson(LogInRequestAction instance) =>
    <String, dynamic>{
      'credentials': instance.credentials,
    };

LogInSucceedAction _$LogInSucceedActionFromJson(Map<String, dynamic> json) {
  return LogInSucceedAction(
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LogInSucceedActionToJson(LogInSucceedAction instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
