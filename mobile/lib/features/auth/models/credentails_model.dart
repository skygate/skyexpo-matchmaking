import 'package:json_annotation/json_annotation.dart';
import "package:equatable/equatable.dart";

part 'credentails_model.g.dart';

@JsonSerializable()
class Credentials extends Equatable {
  String email;
  String password;

  Credentials({this.email, this.password});

  @override
  List<Object> get props => [email, password];

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}
