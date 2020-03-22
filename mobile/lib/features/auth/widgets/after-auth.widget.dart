import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/routes_config.dart' show AppRoute;
import 'package:mobile/core/widgets/layout.widget.dart';

class AfterAuth extends StatelessWidget {
  final String email;

  AfterAuth({Key key, @required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('After auth screen'),
          Text('Store says your email is: $email'),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.home.toString());
            },
            child: Text('Go to home screen'),
          )
        ],
      ),
    ));
  }
}
