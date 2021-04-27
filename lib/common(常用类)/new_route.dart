import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/ui/page/gold/home_page.dart';
import 'package:new_app/ui/page/page_index.dart';
import 'package:new_app/ui/rootpage/tabbar.dart';

/// 文字标识
class StringSMacro {
  // 广告模型标识
  static const String SplashAdModel = "/SpashAdmodel";

  /// Tabbar 标识
  static const String TabberStr = "/";

  static const String SoilStr = '/soil';

  static const String WoodStr = '/wood';

  static const String WaterStr = '/water';

  static const String FireStr = '/fire';

  static const String GoldStr = '/gold';
  static const String GoldHome = '/goldhome';
}

/// 图片标识
class ImageStringMacro {
  /// 引导页图片
  static const String LaunchimageStr = "ios/Runner/launch.png";

  /// tabbar 突出按钮图片
  static const String tabberCenterimgStr = 'images/plus.png';

  ///
  static const String homeStr = 'images/home.png';

  static const String homesStr = 'images/home_s.png';

  static const String findStr = 'images/find.png';

  static const String findsStr = 'images/find_s.png';

  static const String hotStr = 'images/hot.png';

  static const String hotsStr = 'images/hot_s.png';

  static const String myStr = 'images/my.png';

  static const String mysStr = 'images/my_s.png';
}

class RouteManager {
  /// 跳转首页
  static goMain(BuildContext context) {
    pushReplacementPage(context, StringSMacro.GoldStr);
  }

  /*
  跳到指定界面 带返回按钮
  pagename 注册的路由
  暂时没实现
  */
  static pushNamed(BuildContext context, String pageName) {}

  /*
  跳到指定界面 带返回按钮
  安卓风格
  */
  static pushPage(BuildContext context, String pageName) {
    Navigator.push(context, configRouteStr(pageName));
  }

  /*
  跳转指定界面 带返回按钮
  IOS 风格
  */
  static pushCuperPage(BuildContext context, String pageName) {
    Navigator.push(context, configCuPerPageRoute(pageName));
  }

  /*
   * 设置入口页 
   * context
   * Page
  */
  static pushReplacementPage(BuildContext context, String pageName) {
    Navigator.pushReplacement(context, configRouteStr(pageName));
  }

  // 获取带路由的安卓风格 page
  static Route<dynamic> configRouteStr(String name) {
    return MaterialPageRoute(builder: (_) => configCurrentWidgt(name));
  }

  // 获取带路由的IOS风格 page
  static Route<dynamic> configCuPerPageRoute(String name) {
    return CupertinoPageRoute(builder: (_) => configCurrentWidgt(name));
  }

  /*
  * 获取page
  * */
  static Widget configCurrentWidgt(String name) {
    switch (name) {
      case StringSMacro.TabberStr:
        return TTabBar();
        break;
      case StringSMacro.SoilStr:
        return SoilPage();
        break;

      case StringSMacro.FireStr:
        return FirdPage();
        break;

      case StringSMacro.GoldStr:
        return GoldPage();
        break;
      case StringSMacro.GoldHome:
        return HomePage();
        break;

      case StringSMacro.WaterStr:
        return WaterPage();
        break;

      case StringSMacro.WoodStr:
        return WoodPage();
        break;

      default:
        return SoilPage();
    }
  }
}
