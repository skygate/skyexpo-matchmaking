import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
class User {
  String id;
  String email;
  String name;
  String token;
  User({this.id, this.email, this.name, this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
