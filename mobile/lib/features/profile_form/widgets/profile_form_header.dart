import 'package:flutter/material.dart';

import 'package:mobile/config/fonts_config.dart' show FontSize;
import 'package:mobile/config/index.dart' show boldFontWeight;
import '../models/team_model.dart' show Team;

class ProfileFormHeader extends StatelessWidget {
  final Team team;

  ProfileFormHeader({
    @required this.team,
  });

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        Container(
          margin: EdgeInsets.only(right: 24),
          width: 90,
          child: Image.network(
            team.logoUrl,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(team.name,
                style: TextStyle(
                    fontSize: FontSize.normal.value,
                    fontWeight: boldFontWeight)),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text('Team representatives:',
                  style: TextStyle(
                    fontSize: FontSize.small.value,
                  )),
            ),
            Row(
                children: team.membersAvatars
                    .map((avatar) => Container(
                        margin: EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              avatar,
                            ))))
                    .toList())
          ],
        )
      ]));
}
