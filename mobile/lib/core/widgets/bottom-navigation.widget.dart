import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/colors.config.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: colors['background'],
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.mail),
          title: new Text('Messages'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }
}
