import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mobile/config/colors.config.dart';
import 'package:mobile/config/fonts.config.dart';

class TopHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  TopHeader({Key key, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: TextStyle(
                fontSize: fontSizes["veryBig"], color: colors["primary"]),
          ),
          Text(subTitle,
              style: TextStyle(
                  fontSize: fontSizes["big"], color: colors["primary"]))
        ]));
  }
}