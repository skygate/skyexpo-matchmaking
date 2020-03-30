import 'package:flutter/material.dart';

import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/core/configs/bottom_navigation_elements_config.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: AppColor.elementsBackground.value,
        currentIndex: 1,
        iconSize: 30,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        showUnselectedLabels: true,
        items: bottomNavigationElementsConfig
            .map(
              (element) => BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 0),
                  child: Icon(
                    element['icon'],
                    color: element['color'],
                  ),
                ),
                title: Text('.'),
              ),
            )
            .toList());
  }
}
