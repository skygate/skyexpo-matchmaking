import 'package:flutter/material.dart';

import '../mocks/marching_pairs.dart' show matchingListItems;
import '../widgets/matching_list_widget.dart' show MatchingList;

class MatchingListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MatchingList(matchingListItems: matchingListItems);
}
