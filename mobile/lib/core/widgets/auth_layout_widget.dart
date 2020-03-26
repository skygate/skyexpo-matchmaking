import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show appPadding, AppColor;

class AuthLayout extends StatelessWidget {
  final Widget topChild;
  final Widget bottomChild;

  AuthLayout({this.topChild, this.bottomChild});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background.value,
        body: Container(
            margin: new EdgeInsets.only(top: 60.0),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: appPadding),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: topChild,
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      fillOverscroll: true,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: bottomChild,
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
