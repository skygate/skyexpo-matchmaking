import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppColor, boxShadow, redirect;
import 'package:mobile/core/widgets/bottom_navigation_element_widget.dart'
    show getBottomNavigationElement;
import '../configs/bottom_navigation_elements_config.dart'
    show bottomNavigationElementsConfig;

final radius = Radius.circular(30);
final borderRadius = BorderRadius.only(topRight: radius, topLeft: radius);

class BottomNavigation extends StatefulWidget {
  final Function changeTab;

  BottomNavigation({@required this.changeTab});

  @override
  _BottomNavigationState createState() =>
      _BottomNavigationState(changeTab: changeTab);
}

class _BottomNavigationState extends State<BottomNavigation> {
  final Function changeTab;
  int navIndex;

  _BottomNavigationState({@required this.changeTab});

  @override
  void initState() {
    super.initState();
    navIndex = 0;
  }

  void onNavigationButtonTap(index) {
    setState(() {
      navIndex = index;
    });

    changeTab(index);
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          boxShadow,
        ],
      ),
      child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
              color: Colors.white,
              child: BottomNavigationBar(
                  onTap: onNavigationButtonTap,
                  backgroundColor: AppColor.elementsBackground.value,
                  currentIndex: navIndex,
                  iconSize: 30,
                  unselectedIconTheme: IconThemeData(color: Colors.grey),
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: bottomNavigationElementsConfig
                      .asMap()
                      .entries
                      .map(
                        (entry) => getBottomNavigationElement(
                            entry.value['icon'],
                            navIndex == entry.key
                                ? entry.value['color']
                                : Colors.grey),
                      )
                      .toList()))));
}
