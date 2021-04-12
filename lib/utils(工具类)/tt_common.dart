import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 颜色宏定义
class ColorsMacro {
  static const Color col_333 = Color(0xFF333333);
  static const Color col_FFF = Color(0xFFFFFFFF);
  static const Color col_F6F = Color(0xFFF6F6F6);
  static const Color col_CCC = Color(0xFFCCCCCC);
  static const Color col_FAF = Color(0xFFFAFAFA);
  static const Color col_CDA = Color(0xFFCDA756);
  static const Color col_666 = Color(0xFF666666);
  static const Color col_E5E = Color(0xFFE5E5E5);
  static const Color col_999 = Color(0xFF999999);
  static const Color col_EEE = Color(0xFFEEEEEE);
  static const Color col_D92 = Color(0xFFD92B24);
  static const Color col_F7F = Color(0xFFF7F7F7);
}

class Utils {
  /// 获取本地图片
  static String getImagePath(String name,
      {String format: 'png', String lib: 'images'}) {
    return '$lib/$name.$format';
  }
}

class SizeMacro {
  // 屏幕宽
  double screenWidth = ScreenUtil().screenWidth;
  // 屏幕高
  double screenHeight = ScreenUtil().screenHeight;
  // 系统状态栏高度
  double statusBarHeight = ScreenUtil().statusBarHeight;
  // 底部安全举例距离BottomBar高度
  double bottomBarHeight = ScreenUtil().bottomBarHeight;

  // 获取适配  width 宽
  double setWidth(double width) {
    return width.w;
  }

  // 获取适配  height 高
  double setHeight(double height) {
    return height.h;
  }
}
