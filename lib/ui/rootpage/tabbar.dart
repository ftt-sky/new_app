import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/common(常用类)/new_route.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class TTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TTabBarState();
  }
}

class TTabBarState extends State<TTabBar> {
  /// 属性
  ///
  ///

  /// 选中下标
  int _tabIndex = 0;

  var _body;

  /// 底部图片数组
  var _tabItemages;

  var _appBarTitles = ['金', '木', '水', '火', '土'];

  var _appBarWidgetNames = [
    StringSMacro.GoldStr,
    StringSMacro.WoodStr,
    StringSMacro.WaterStr,
    StringSMacro.FireStr,
    StringSMacro.SoilStr
  ];

  /// 未选中字体颜色
  final _taBTextStyleNormal = TextStyle(color: ColorsMacro.col_999);

  /// 选中字体颜色
  final _taBTextStyleSelected = TextStyle(color: ColorsMacro.col_333);

  /// 生命周期
  ///
  ///
  ///

  @override
  Widget build(BuildContext context) {
    initData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: ColorsMacro.col_FFF),
      home: Scaffold(
        body: _body,
        floatingActionButton: configFloatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: configBottomAppBar(),
      ),
    );
  }

  /// 触发方法
  ///
  ///

  /// 数据
  ///
  ///

  initData() {
    var imagearr = ['images/home', 'images/home', 'images/hot', 'images/my'];
    if (_tabItemages == null) {
      _tabItemages = [
        [
          getTabImage(imagearr[0] + '.png'),
          getTabImage(imagearr[0] + '_s' + '.png')
        ],
        [
          getTabImage(imagearr[1] + '.png'),
          getTabImage(imagearr[1] + '_s' + '.png')
        ],
        [],
        [
          getTabImage(imagearr[2] + '.png'),
          getTabImage(imagearr[2] + '_s' + '.png')
        ],
        [
          getTabImage(imagearr[3] + '.png'),
          getTabImage(imagearr[3] + '_s' + '.png')
        ]
      ];
    }

    _body = IndexedStack(
      children: configTabBarWidget(),
      index: _tabIndex,
    );
  }

  /// 私有方法
  ///
  ///

  Widget getTabBar() {
    if (Platform.isIOS) {
      return CupertinoTabBar(
        items: getBottomNavItems(),
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      );
    } else {
      return BottomNavigationBar(
        items: getBottomNavItems(),
        currentIndex: _tabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        selectedFontSize: 14,
        unselectedFontSize: 12,
        fixedColor: Colors.green,
      );
    }
  }

  /// 加载图片
  Image getTabImage(path) {
    if (path.startsWith('http')) {
      return Image.asset(path, width: 20, height: 20);
    } else {
      return Image.asset(path, width: 32, height: 32);
    }
  }

  /// 获取按钮图片
  Image getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabItemages[index][1];
    }
    return _tabItemages[index][0];
  }

  /// 创建底部按钮
  List<BottomNavigationBarItem> getBottomNavItems() {
    List<BottomNavigationBarItem> list = [];
    for (var i = 0; i < _appBarTitles.length; i++) {
      list.add(configBottomBarItem(i));
    }
    return list;
  }

  BottomNavigationBarItem configBottomBarItem(int index) {
    var bottomNavigationBarItem = BottomNavigationBarItem(
      icon: getTabIcon(index),
      label: _appBarTitles[index],
    );
    return bottomNavigationBarItem;
  }

  /// 获取字体
  Text getTabTitle(int index) {
    return Text(
      _appBarTitles[index],
      style: getTabTextStyle(index),
    );
  }

  /// 创建中间按钮
  Widget configFloatButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          _tabIndex = 2;
        });
      },
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: Image.asset(
        ImageStringMacro.tabberCenterimgStr,
        width: 60,
        height: 60,
      ),
      label: Text(''),
    );
  }

  /// 创建对应的widget
  List<Widget> configTabBarWidget() {
    List<Widget> list = [];
    for (int i = 0; i < _appBarWidgetNames.length; i++) {
      list.add(RouteManager.configCurrentWidgt(_appBarWidgetNames[i]));
    }
    return list;
  }

  /// 设置按钮字体
  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return _taBTextStyleSelected;
    } else {
      return _taBTextStyleNormal;
    }
  }

  /// 创建bottomAppBar
  Widget configBottomAppBar() {
    return BottomAppBar(
      color: Theme.of(context).accentColor,
      shape: AutomaticNotchedShape(RoundedRectangleBorder(),
          BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: configBottomAppBarChild(),
    );
  }

  /// 创建bottomAppBar 子控件配置
  Widget configBottomAppBarChild() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: configBottomChildWidget(),
    );
  }

  /// 最终创建按钮子控件
  List<Widget> configBottomChildWidget() {
    List<Widget> list = [];
    for (var i = 0; i < _appBarTitles.length; i++) {
      if (i == 2) {
        list.add(
          SizedBox(),
        );
      } else {
        list.add(GestureDetector(
          onTap: () {
            setState(() {
              _tabIndex = i;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [getTabIcon(i), getTabTitle(i)],
          ),
        ));
      }
    }
    return list;
  }
}
