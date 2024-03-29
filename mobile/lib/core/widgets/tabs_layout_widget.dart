import 'package:flutter/material.dart';

import 'package:mobile/common/widgets/top-header.widget.dart' show TopHeader;
import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/config/values_config.dart' show appPadding;
import 'package:mobile/core/widgets/solid_tab_indicator_widget.dart'
    show SolidIndicator;

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
  _TabsLayoutState createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: widget.tabs.length,
      child: Scaffold(
        backgroundColor: AppColor.background.value,
        appBar: AppBar(
            titleSpacing: 0.0,
            backgroundColor: AppColor.background.value,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size(
                  0, 100), // first param don't have impact on anything here
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: appPadding,
                ),
                child: Column(children: [
                  TopHeader(
                    title: widget.title,
                    subTitle: widget.subTitle,
                    avatarUrl: widget.avatarUrl,
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TabBar(
                        indicator: SolidIndicator(),
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        tabs: widget.tabs,
                      )),
                ]),
              ),
            )),
        body: TabBarView(
          controller: _tabController,
          children: widget.tabsBody,
        ),
      ));
}
