import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/colors_config.dart' show AppColor;

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColor.background.value,
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
