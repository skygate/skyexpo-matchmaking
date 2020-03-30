import 'package:flutter/material.dart';

import 'package:mobile/common/widgets/top-header.widget.dart' show TopHeader;
import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/config/values_config.dart' show appPadding;
import 'package:mobile/core/widgets/solid_tab_indicator_widget.dart'
    show SolidIndicator;
import 'bottom_navigation_widget.dart';

final tabsPadding = EdgeInsets.only(
  left: appPadding,
  right: appPadding,
  top: 25,
);

class TabsLayout extends StatefulWidget {
  final String title;
  final String subTitle;
  final String avatarUrl;
  final List<Widget> tabs;
  final List<Widget> tabsBody;

  TabsLayout(
      {@required this.tabs,
      @required this.tabsBody,
      @required this.title,
      @required this.subTitle,
      @required this.avatarUrl})
      : assert(tabs.length == tabsBody.length);

  @override
  _TabsLayoutState createState() => _TabsLayoutState(
      title: title,
      subTitle: subTitle,
      tabs: tabs,
      tabsBody: tabsBody,
      avatarUrl: avatarUrl);
}

class _TabsLayoutState extends State<TabsLayout>
    with SingleTickerProviderStateMixin {
  final String title;
  final String subTitle;
  final String avatarUrl;
  final List<Widget> tabs;
  final List<Widget> tabsBody;
  TabController _tabController;

  _TabsLayoutState(
      {@required this.tabs,
      @required this.tabsBody,
      @required this.title,
      @required this.subTitle,
      @required this.avatarUrl})
      : assert(tabs.length == tabsBody.length);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            backgroundColor: AppColor.background.value,
            appBar: AppBar(
              titleSpacing: 0.0,
              backgroundColor: AppColor.background.value,
              elevation: 0.0,
              bottom: PreferredSize(
                  preferredSize: Size(60, 80),
                  child: Padding(
                      padding: tabsPadding,
                      child: TabBar(
                        indicator: SolidIndicator(),
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        tabs: tabs,
                      ))),
              title: Padding(
                  padding: tabsPadding,
                  child: TopHeader(
                    title: title,
                    subTitle: subTitle,
                    avatarUrl: avatarUrl,
                  )),
            ),
            body: TabBarView(
              controller: _tabController,
              children: tabsBody,
            ),
            bottomNavigationBar: BottomNavigation()),
      );
}
