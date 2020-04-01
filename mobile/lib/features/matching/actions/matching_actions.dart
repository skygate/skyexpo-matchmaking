import 'package:json_annotation/json_annotation.dart';
import '../models/matching_pair_model.dart';

part 'matching_actions.g.dart';

@JsonSerializable()
class GetMatchingPairsRequestAction {
  final int userId;

  GetMatchingPairsRequestAction(this.userId);

  factory GetMatchingPairsRequestAction.fromJson(Map<String, dynamic> json) =>
      _$GetMatchingPairsRequestActionFromJson(json);
  Map<String, dynamic> toJson() => _$GetMatchingPairsRequestActionToJson(this);
}

@JsonSerializable()
class GetMatchingPairsSucceedAction {
  final List<MatchingPair> matchingPairs;
  GetMatchingPairsSucceedAction(this.matchingPairs);

  factory GetMatchingPairsSucceedAction.fromJson(Map<String, dynamic> json) =>
      _$GetMatchingPairsSucceedActionFromJson(json);
  Map<String, dynamic> toJson() => _$GetMatchingPairsSucceedActionToJson(this);
}

class GetMatchingPairsFailedAction {}
