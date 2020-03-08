import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/routes.config.dart';

class AfterAuth extends StatelessWidget {
  AfterAuth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('After auth screen'),
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, routes["home"]),
            child: Text('Go to home screen'),
          )
        ],
      ),
    ));
  }
}
