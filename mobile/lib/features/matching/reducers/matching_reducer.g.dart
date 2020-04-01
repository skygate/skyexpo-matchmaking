// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_reducer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchingState _$MatchingStateFromJson(Map<String, dynamic> json) {
  return MatchingState(
    matchingPairs: (json['matchingPairs'] as List)
        ?.map((e) =>
            e == null ? null : MatchingPair.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isLoading: json['isLoading'] as bool,
  );
}

Map<String, dynamic> _$MatchingStateToJson(MatchingState instance) =>
    <String, dynamic>{
      'matchingPairs': instance.matchingPairs,
      'isLoading': instance.isLoading,
    };
