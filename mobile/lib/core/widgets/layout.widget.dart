import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/colors.config.dart';

import 'bottom-navigation.widget.dart';

class Layout extends StatelessWidget {
  final Widget child;

  Layout({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors['background'],
        drawerScrimColor: colors['background'],
        appBar: AppBar(
          backgroundColor: colors['background'],
          elevation: 0.0,
        ),
        body: child,
        bottomNavigationBar: BottomNavigation());
  }
}
