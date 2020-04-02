// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_form_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileFormData _$ProfileFormDataFromJson(Map<String, dynamic> json) {
  return ProfileFormData(
    avatar: json['avatar'] as String,
    phone: json['phone'] as String,
    country: json['country'] as String,
    proffesion: json['proffesion'] as String,
    role: json['role'] as String,
    gender: json['gender'] == null
        ? null
        : Gender.fromJson(json['gender'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileFormDataToJson(ProfileFormData instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'phone': instance.phone,
      'country': instance.country,
      'proffesion': instance.proffesion,
      'role': instance.role,
      'gender': instance.gender,
    };
