import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/common/widgets/on_init_widget.dart';
import 'package:mobile/features/matching/actions/matching_actions.dart';
import 'package:mobile/features/matching/models/matching_pair_model.dart';
import 'package:mobile/features/matching/selectors/matching_selectors.dart';
import 'package:mobile/store/app_state.dart';
import 'package:redux/redux.dart';

import '../widgets/matching_tabs_widget.dart' show MatchingTabs;

class MatchingListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        void getMatchingPairs() => vm.getMatchingPairsRequestAction(userId: 1);

        return OnInitWrapper(
            onInit: getMatchingPairs,
            child: MatchingTabs(
              matchingListItems: vm.matchingPairs,
              avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
            ));
      });
}

class _ViewModel {
  final Function getMatchingPairsRequestAction;
  final List<MatchingPair> matchingPairs;

  _ViewModel(
      {@required this.getMatchingPairsRequestAction,
      @required this.matchingPairs});

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        getMatchingPairsRequestAction: ({userId}) =>
            store.dispatch(GetMatchingPairsRequestAction(userId)),
        matchingPairs: getMatchingPairs(store.state),
      );
}
