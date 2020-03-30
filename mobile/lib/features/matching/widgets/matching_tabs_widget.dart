import 'package:flutter/material.dart';

import 'package:mobile/core/widgets/tabs_layout_widget.dart';
import '../configs/matching_tabs_config.dart';
import '../models/matching_pair_model.dart';
import 'matching_list_widget.dart';
import 'matching_tab_widget.dart';

class MatchingTabs extends StatelessWidget {
  final List<MatchingPair> matchingListItems;

  MatchingTabs({@required this.matchingListItems});

  @override
  Widget build(BuildContext context) => TabsLayout(
        tabs: matchingTabsList
            .map((tab) => MatchingTab(
                  title: tab['name'],
                  size: tab['size'],
                  numberOfTabs: matchingTabsList.length,
                ))
            .toList(),
        tabsBody: <Widget>[
          MatchingList(matchingListItems: matchingListItems),
          MatchingList(matchingListItems: matchingListItems),
          MatchingList(matchingListItems: matchingListItems),
          MatchingList(matchingListItems: matchingListItems),
        ],
        title: 'Matching list',
        subTitle:
            matchingListItems.length.toString() + 'proposal of connections',
      );
}
