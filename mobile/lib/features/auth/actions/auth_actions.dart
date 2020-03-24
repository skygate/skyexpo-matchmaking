import 'package:json_annotation/json_annotation.dart';

import 'package:mobile/features/auth/models/credentails_model.dart'
    show Credentials;
import 'package:mobile/features/auth/models/user_model.dart' show User;

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
