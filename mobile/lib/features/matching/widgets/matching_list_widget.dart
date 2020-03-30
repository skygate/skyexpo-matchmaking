import 'package:flutter/material.dart';

import 'package:mobile/config/values_config.dart' show appPadding;
import '../models/matching_pair_model.dart' show MatchingPair;
import 'matching_card_widget.dart' show MatchingCard;

class MatchingList extends StatelessWidget {
  final List<MatchingPair> matchingListItems;
  MatchingList({@required this.matchingListItems});

  @override
  Widget build(BuildContext context) => ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: matchingListItems
            .map((matchingPair) => Padding(
                padding: EdgeInsets.symmetric(horizontal: appPadding),
                child: MatchingCard(
                  matchingPair: matchingPair,
                )))
            .toList(),
      );
}
