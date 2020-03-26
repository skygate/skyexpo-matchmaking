import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppRoute, FontSize;
import 'package:mobile/config/routes_config.dart' show redirect;

class AuthSwitchLink extends StatelessWidget {
  final AppRoute path;
  final String title;

  AuthSwitchLink({
    @required this.path,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => redirect(AppRoute.home),
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontSize: FontSize.small.value),
          )),
        ));
  }
}
