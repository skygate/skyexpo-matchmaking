import 'dart:async';
import 'package:redux_epics/redux_epics.dart' show EpicStore, combineEpics;
import 'package:rxdart/rxdart.dart';

import '../services/matching_service.dart';
import '../actions/matching_actions.dart'
    show
        GetMatchingPairsRequestAction,
        GetMatchingPairsSucceedAction,
        GetMatchingPairsFailedAction;

matchigEpicsFactory<T>(MatchingService matchingService) {
  Stream<dynamic> getMatchingPairsEpic(
          Stream<dynamic> actions, EpicStore<T> store) =>
      actions.whereType<GetMatchingPairsRequestAction>().asyncMap((action) =>
          matchingService.getMatchingParis(userId: action.userId).then(
              (matchingPairs) => GetMatchingPairsSucceedAction(matchingPairs),
              onError: (error) => GetMatchingPairsFailedAction()));

  return combineEpics<T>([getMatchingPairsEpic]);
}
