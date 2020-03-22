import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mobile/config/colors.config.dart' show AppColor;
import 'package:mobile/config/fonts.config.dart' show FontSize;

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
                fontSize: FontSize.veryBig.value,
                color: AppColor.primary.value),
          ),
          Text(subTitle,
              style: TextStyle(
                  fontSize: FontSize.big.value, color: AppColor.primary.value))
        ]));
  }
}
