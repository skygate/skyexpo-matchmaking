import 'package:flutter/material.dart';

import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/config/fonts_config.dart' show FontSize, boldFontWeight;

class TopHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final String avatarUrl;

  TopHeader(
      {@required this.title,
      @required this.subTitle,
      @required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: FontSize.big.value,
                  color: AppColor.primary.value,
                  fontWeight: boldFontWeight),
            ),
            Text(subTitle,
                style: TextStyle(
                    fontSize: FontSize.small.value,
                    color: AppColor.primary.value))
          ]),
          CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                avatarUrl,
              ))
        ]));
  }
}
