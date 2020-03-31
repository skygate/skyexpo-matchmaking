import 'package:redux/redux.dart' show TypedReducer, combineReducers;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

import '../actions/matching_actions.dart' as actions;
import 'package:mobile/features/matching/models/matching_pair_model.dart'
    show MatchingPair;

part 'matching_reducer.g.dart';

@JsonSerializable()
class MatchingState {
  final List<MatchingPair> matchingPairs;
  final bool isLoading;

  MatchingState({this.matchingPairs, this.isLoading = false});

  factory MatchingState.fromJson(Map<String, dynamic> json) =>
      _$MatchingStateFromJson(json);
  Map<String, dynamic> toJson() => _$MatchingStateToJson(this);
}

final matchingReducer = combineReducers<MatchingState>([
  TypedReducer<MatchingState, actions.GetMatchingPairsSucceedAction>(
      getMatchingPairsSuccedReducer),
]);

MatchingState getMatchingPairsSuccedReducer(
        matchingState, actions.GetMatchingPairsSucceedAction action) =>
    MatchingState(matchingPairs: action.matchingPairs);
