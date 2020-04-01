import 'package:json_annotation/json_annotation.dart';

import 'gender_model.dart' show Gender;

part 'profile_form_data_model.g.dart';

@JsonSerializable()
class ProfileFormData {
  String avatar;
  String phone;
  String country;
  String proffesion;
  String role;
  Gender gender;

  ProfileFormData(
      {this.avatar,
      this.phone,
      this.country,
      this.proffesion,
      this.role,
      this.gender});

  factory ProfileFormData.fromJson(Map<String, dynamic> json) =>
      _$ProfileFormDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileFormDataToJson(this);
}
