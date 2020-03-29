import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:mobile/config/fonts_config.dart';
import '../models/matching_pair_model.dart';

const cardElementPadding = EdgeInsets.all(16);

class MatchingCard extends StatelessWidget {
  final MatchingPair matchingPair;
  MatchingCard({@required this.matchingPair});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: cardElementPadding,
              child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    matchingPair.avatarUrl,
                  )),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                matchingPair.name,
                style: TextStyle(
                    fontSize: FontSize.normal.value,
                    fontWeight: FontWeight.w800),
              ),
              Text(matchingPair.tags)
            ]),
            Spacer(),
            Padding(
              padding: cardElementPadding,
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 6.0,
                percent: matchingPair.percent / 100,
                center: new Text(matchingPair.percent.toString() + '%',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                progressColor: Colors.purple,
              ),
            ),
          ],
        ));
  }
}
