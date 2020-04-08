import 'package:flutter/cupertino.dart';

import 'package:mobile/config/index.dart' show AppRoute, FontSize;
import 'package:mobile/config/routes_config.dart' show redirect;

class AuthSwitchLink extends StatelessWidget {
  final AppRoute route;
  final String title;

  AuthSwitchLink({
    @required this.route,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => redirect(route),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: FontSize.small.value),
        )),
      ));
}
