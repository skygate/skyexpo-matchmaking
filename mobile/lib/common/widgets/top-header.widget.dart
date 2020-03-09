import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  TopHeader({Key key, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text(title),
        Text(subTitle),
      ],
    ));
  }
}
