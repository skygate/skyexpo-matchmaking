import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/index.dart' show appPadding, AppColor;

class AuthLayout extends StatelessWidget {
  final Widget child;

  AuthLayout({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background.value,
        body: Container(
            margin: new EdgeInsets.only(top: 70.0),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: appPadding),
                child: child)));
  }
}
