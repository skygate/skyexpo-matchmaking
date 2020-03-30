import 'package:flutter/material.dart';

import 'package:mobile/config/colors_config.dart' show AppColor;
import '../configs/bottom_navigation_elements_config.dart'
    show bottomNavigationElementsConfig;

final radius = Radius.circular(30);
final bordeRadius = BorderRadius.only(topRight: radius, topLeft: radius);

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: bordeRadius,
          boxShadow: [
            BoxShadow(color: Colors.grey[400], spreadRadius: 0, blurRadius: 1),
          ],
        ),
        child: ClipRRect(
            borderRadius: bordeRadius,
            child: Container(
                color: Colors.white,
                child: BottomNavigationBar(
                    backgroundColor: AppColor.elementsBackground.value,
                    currentIndex: 1,
                    iconSize: 30,
                    unselectedIconTheme: IconThemeData(color: Colors.grey),
                    showUnselectedLabels: true,
                    items: bottomNavigationElementsConfig
                        .map(
                          (element) => BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Icon(
                                element['icon'],
                                color: element['color'],
                              ),
                            ),
                            title: Text(''),
                          ),
                        )
                        .toList()))));
  }
}
