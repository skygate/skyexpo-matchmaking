import 'package:flutter/material.dart';

BottomNavigationBarItem getBottomNavigationElement(
        IconData icon, Color color) =>
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      title: Text(''),
    );
