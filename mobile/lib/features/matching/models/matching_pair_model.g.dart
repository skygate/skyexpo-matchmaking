// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_pair_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchingPair _$MatchingPairFromJson(Map<String, dynamic> json) {
  return MatchingPair(
    id: json['id'] as int,
    name: json['name'] as String,
    tags: json['tags'] as String,
    percent: json['percent'] as int,
    avatarUrl: json['avatarUrl'] as String,
  );
}

Map<String, dynamic> _$MatchingPairToJson(MatchingPair instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tags': instance.tags,
      'percent': instance.percent,
      'avatarUrl': instance.avatarUrl,
    };
