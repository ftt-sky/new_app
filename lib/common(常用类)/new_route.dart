import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/ui/page/soil.dart';

/// 文字标识
class StringSMacro {
  // 广告模型标识
  static const String SplashAdModel = "/SpashAdmodel";

  static const String TabberStr = "/";
  static const String SoilStr = '/soil';
}

/// 图片标识
class ImageStringMacro {
  /// 引导页图片
  static const String LaunchimageStr = "ios/Runner/launch.png";
}

class RouteManager {
  /// 跳转首页
  static goMain(BuildContext context) {
    pushReplacementPage(context, StringSMacro.SoilStr);
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
      case StringSMacro.SoilStr:
        return SoilPage();
        break;
      default:
        return SoilPage();
    }
  }
}
