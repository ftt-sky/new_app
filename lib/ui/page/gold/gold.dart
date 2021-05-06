import 'package:flutter/material.dart';

import 'package:new_app/res(资源文件)/res_index.dart';
import 'package:new_app/ui/page/gold/events_page.dart';
import 'package:new_app/ui/page/gold/home_page.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_logutils.dart';
import 'gold_lift.dart';
import 'repos_page.dart';
import 'System_page.dart';
import 'events_page.dart';

class _Page {
  final String lableId;
  final String title;
  _Page(this.lableId, this.title);
}

final List<_Page> _allPages = <_Page>[
  _Page(CurrentIds.titleHome, "首页"),
  _Page(CurrentIds.titleRepos, "项目"),
  _Page(CurrentIds.titleEvents, '动态'),
  _Page(CurrentIds.titleSystem, "体系")
];

class GoldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return createTabController();
  }

  Widget createTabController() {
    TTLog.d(_allPages.length);
    return DefaultTabController(
        length: _allPages.length, child: createScaffold());
  }

  Widget createScaffold() {
    return Scaffold(
      appBar: AppBar(
        // leading: Builder(builder: (BuildContext ctx) {
        //   return IconButton(
        //       icon: Icon(Icons.person),
        //       color: Colors.red,
        //       onPressed: () {
        //         Scaffold.of(ctx).openDrawer();
        //       });
        // }),
        centerTitle: true,
        title: TabLayout(),
        //actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: TabBarViewLayout(),
      // drawer: Drawer(
      //   child: GoldLeftPage(),
      // ),
    );
  }
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: Colors.black,
      indicatorWeight: 2.0,
      unselectedLabelColor: Colors.white,
      labelPadding: EdgeInsets.all(12),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.black,
      tabs: _allPages.map((_Page page) {
        return Tab(text: page.title);
      }).toList(),
    );
  }
}

class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, _Page page) {
    String labelId = page.lableId;
    switch (labelId) {
      case CurrentIds.titleHome:
        return HomePage(labelId: labelId);
        break;
      case CurrentIds.titleRepos:
        return ReposPage(labelId: labelId);
      case CurrentIds.titleEvents:
        return EventsPage(labelId: labelId);
      case CurrentIds.titleSystem:
        return SystemPage(labelId: labelId);
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    TTLog.v('obj');
    return TabBarView(
        children: _allPages.map((_Page page) {
      return buildTabView(context, page);
    }).toList());
  }
}
