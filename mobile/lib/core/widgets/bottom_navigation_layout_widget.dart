import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppColor;
import 'package:mobile/routes.dart' show bottomNavigationTabsBodyList;
import 'bottom_navigation_widget.dart';

class BottomNavigationLayout extends StatefulWidget {
  @override
  _TabsLayoutState createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<BottomNavigationLayout>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: bottomNavigationTabsBodyList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void changeTab(index) => _tabController.animateTo(index);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
            backgroundColor: AppColor.background.value,
            body: TabBarView(
              controller: _tabController,
              children: bottomNavigationTabsBodyList,
            ),
            bottomNavigationBar: BottomNavigation(changeTab: changeTab)),
      );
}
