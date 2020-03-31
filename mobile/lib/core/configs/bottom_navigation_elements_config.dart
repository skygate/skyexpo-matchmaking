import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart';

final List<Map> bottomNavigationElementsConfig = [
  {
    'icon': Icons.people_outline,
    'color': Colors.purple,
    "route": BottomNavigationRoute.matchingList
  },
  {
    'icon': Icons.calendar_today,
    'color': Colors.pink,
    "route": BottomNavigationRoute.calendar
  },
  {
    'icon': Icons.mail_outline,
    'color': Colors.blue,
    "route": BottomNavigationRoute.notifications
  },
  {
    'icon': Icons.settings,
    'color': Colors.orange,
    "route": BottomNavigationRoute.settings
  }
];
