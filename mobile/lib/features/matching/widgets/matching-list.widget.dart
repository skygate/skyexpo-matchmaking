import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/top-header.widget.dart';

import 'package:mobile/core/widgets/layout.widget.dart';

class MatchingList extends StatelessWidget {
  final dynamic matchingLis;

  MatchingList({Key key, @required this.matchingLis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Column(
      children: [
        TopHeader(
            title: 'Matching list', subTitle: '98 proposal of connection'),
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Text('1'),
            Text('2'),
          ],
        )
      ],
    ));
  }
}
