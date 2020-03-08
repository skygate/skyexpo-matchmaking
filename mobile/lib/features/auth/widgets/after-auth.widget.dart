import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/routes.config.dart';

class AfterAuth extends StatelessWidget {
  final String email;

  AfterAuth({Key key, @required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('After auth screen'),
          Text('Store says your email is: $email'),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, routes["home"]);
            },
            child: Text('Go to home screen'),
          )
        ],
      ),
    ));
  }
}
