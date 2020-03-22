import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/colors.config.dart' show AppColor;

import 'bottom-navigation.widget.dart';

class Layout extends StatelessWidget {
  final Widget child;

  Layout({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: AppBar(
              backgroundColor: AppColor.background.value,
              elevation: 0.0,
            )),
        body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20), child: child),
        bottomNavigationBar: BottomNavigation());
  }
}
