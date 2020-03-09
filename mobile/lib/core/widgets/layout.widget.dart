import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom-navigation.widget.dart';

class Layout extends StatelessWidget {
  final Widget child;

  Layout({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child, bottomNavigationBar: BottomNavigation());
  }
}
