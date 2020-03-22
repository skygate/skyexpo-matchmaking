import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/routes_config.dart' show AppRoute;

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Home screen'),
          RaisedButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoute.logIn.toString()),
            child: Text('Go to login page'),
          )
        ],
      ),
    ));
  }
}
