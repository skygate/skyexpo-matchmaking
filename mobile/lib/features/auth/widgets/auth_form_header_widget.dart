import 'package:flutter/material.dart';

import 'package:mobile/config/fonts_config.dart' show FontSize, boldFontWeight;

class AuthFormHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  AuthFormHeader({@required this.title, @required this.subTitle});

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(bottom: 40),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: FontSize.veryBig.value,
                  fontWeight: boldFontWeight)),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(subTitle,
                  style: TextStyle(fontSize: FontSize.normal.value))),
        ],
      ));
}
