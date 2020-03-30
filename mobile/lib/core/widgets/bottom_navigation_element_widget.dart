import 'package:flutter/material.dart';

import 'package:mobile/config/colors_config.dart' show AppColor;

getBottomNavigationElement(IconData icon, String text) =>
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 5),
        child: Icon(icon),
      ),
      title: Text(text),
    );
