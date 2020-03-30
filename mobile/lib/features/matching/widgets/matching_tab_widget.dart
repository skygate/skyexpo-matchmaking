import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart';
import '../helpers/get_tab_width.dart';

class MatchingTab extends StatelessWidget {
  final String title;
  final double size;
  final int numberOfTabs;

  MatchingTab(
      {@required this.title, @required this.size, @required this.numberOfTabs});

  @override
  Widget build(BuildContext context) => Tab(
      icon: Container(
          width: getTabWidth(
              context: context, numberOfTabs: numberOfTabs, size: size),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
                fontSize: FontSize.small.value, color: AppColor.primary.value),
          ))));
}
