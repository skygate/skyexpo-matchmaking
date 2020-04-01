import 'package:vnum/vnum.dart' show Vnum, VnumDefinition;
import 'package:json_annotation/json_annotation.dart';

part 'gender_model.g.dart';

@JsonSerializable()
@VnumDefinition
class Gender extends Vnum<String> {
  static const Gender man = const Gender.define("MAN");
  static const Gender woman = const Gender.define("WOMAN");
  static const Gender other = const Gender.define("OTHER");

  const Gender.define(String fromValue) : super.define(fromValue);
  factory Gender(String value) => Vnum.fromValue(value, Gender);

  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);
  Map<String, dynamic> toJson() => _$GenderToJson(this);
}
