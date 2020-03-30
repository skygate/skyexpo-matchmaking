import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppRoute;

final List<Map> bottomNavigationElementsConfig = [
  {
    'icon': Icons.people_outline,
    'color': Colors.purple,
    "route": AppRoute.matchingList
  },
  {
    'icon': Icons.calendar_today,
    'color': Colors.pink,
    "route": AppRoute.calendar
  },
  {
    'icon': Icons.mail_outline,
    'color': Colors.blue,
    "route": AppRoute.notifications
  },
  {'icon': Icons.settings, 'color': Colors.orange, "route": AppRoute.settings}
];
