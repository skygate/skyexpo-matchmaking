import 'package:flutter/material.dart';

import '../widgets/matching_tabs_widget.dart';
import '../mocks/marching_pairs.dart' show matchingListItems;

class MatchingListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MatchingTabs(matchingListItems: matchingListItems);
}
