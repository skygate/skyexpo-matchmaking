import 'package:json_annotation/json_annotation.dart';

part 'credentails.model.g.dart';

@JsonSerializable()
class Credentials {
  String email;
  String password;

  Credentials({this.email, this.password});

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}
