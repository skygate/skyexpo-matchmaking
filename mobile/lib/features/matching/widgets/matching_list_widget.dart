import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mobile/common/widgets/top-header.widget.dart' show TopHeader;
import 'package:mobile/core/widgets/layout_widget.dart' show Layout;
import 'package:mobile/features/matching/widgets/matching_card_widget.dart'
    show MatchingCard;

class MatchingList extends StatelessWidget {
  MatchingList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Column(
      children: [
        TopHeader(
            title: 'Matching list', subTitle: '98 proposal of connection'),
        Flexible(
            child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            MatchingCard(),
            MatchingCard(),
            MatchingCard(),
            MatchingCard(),
            MatchingCard(),
            MatchingCard(),
            MatchingCard(),
          ],
        ))
      ],
    ));
  }
}
