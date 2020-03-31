import 'package:reselect/reselect.dart' show createSelector1;

import 'package:mobile/store/app_state.dart' show AppState;
import '../reducers/matching_reducer.dart';

final getMatchingStateSelector = (AppState state) => state.matching;

final getMatchingPairs = createSelector1(getMatchingStateSelector,
    (MatchingState matchingState) => matchingState.matchingPairs);
