// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMatchingPairsRequestAction _$GetMatchingPairsRequestActionFromJson(
    Map<String, dynamic> json) {
  return GetMatchingPairsRequestAction(
    json['userId'] as int,
  );
}

Map<String, dynamic> _$GetMatchingPairsRequestActionToJson(
        GetMatchingPairsRequestAction instance) =>
    <String, dynamic>{
      'userId': instance.userId,
    };

GetMatchingPairsSucceedAction _$GetMatchingPairsSucceedActionFromJson(
    Map<String, dynamic> json) {
  return GetMatchingPairsSucceedAction(
    (json['matchingPairs'] as List)
        ?.map((e) =>
            e == null ? null : MatchingPair.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetMatchingPairsSucceedActionToJson(
        GetMatchingPairsSucceedAction instance) =>
    <String, dynamic>{
      'matchingPairs': instance.matchingPairs,
    };
