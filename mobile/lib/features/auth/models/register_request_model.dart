import 'package:json_annotation/json_annotation.dart';
import "package:equatable/equatable.dart";

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequest extends Equatable {
  final String email;
  final String password;
  final String name;

  RegisterRequest({this.email, this.password, this.name});

  @override
  List<Object> get props => [email, password];

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
