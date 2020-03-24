import 'package:flutter/cupertino.dart';

import 'package:mobile/config/fonts_config.dart' show FontSize;

class AuthFormHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  AuthFormHeader({Key key, @required this.title, @required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.only(bottom: 50.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: FontSize.veryBig.value)),
            Text(subTitle, style: TextStyle(fontSize: FontSize.normal.value)),
          ],
        ));
  }
}
