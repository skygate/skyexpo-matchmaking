import 'package:json_annotation/json_annotation.dart';

import '../models/index.dart' show Credentials, RegisterRequest, User;

part 'auth_actions.g.dart';

@JsonSerializable()
class LogInRequestAction {
  final Credentials credentials;

  LogInRequestAction(this.credentials);

  factory LogInRequestAction.fromJson(Map<String, dynamic> json) =>
      _$LogInRequestActionFromJson(json);
  Map<String, dynamic> toJson() => _$LogInRequestActionToJson(this);
}

@JsonSerializable()
class LogInSucceedAction {
  final User user;

  LogInSucceedAction(this.user);

  factory LogInSucceedAction.fromJson(Map<String, dynamic> json) =>
      _$LogInSucceedActionFromJson(json);
  Map<String, dynamic> toJson() => _$LogInSucceedActionToJson(this);
}

class LogInFailedAction {}

@JsonSerializable()
class RegisterRequestAction {
  final RegisterRequest registerRequest;

  RegisterRequestAction(this.registerRequest);

  factory RegisterRequestAction.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestActionFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestActionToJson(this);
}

@JsonSerializable()
class RegisterSucceedAction {
  final User user;

  RegisterSucceedAction(this.user);

  factory RegisterSucceedAction.fromJson(Map<String, dynamic> json) =>
      _$RegisterSucceedActionFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterSucceedActionToJson(this);
}

class RegisterFailedAction {}
