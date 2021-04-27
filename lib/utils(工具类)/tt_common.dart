import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/event(%E4%BA%8B%E4%BB%B6%E7%B1%BB)/event.dart';
import 'package:common_utils/common_utils.dart';

/// 颜色宏定义
class ColorsMacro {
  static Color getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(200),
        Random.secure().nextInt(200), Random.secure().nextInt(200));
  }

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

  static RequestStatus getLoadStatus(bool hasError, List data) {
    if (hasError) return RequestStatus.fail;
    if (data == null) {
      return RequestStatus.loading;
    } else if (data.isEmpty) {
      return RequestStatus.noMore;
    } else {
      return RequestStatus.success;
    }
  }

  /// 时间转换
  static String getTimeLine(BuildContext context, int timeMillis) {
    return TimelineUtil.format(timeMillis,
        locale: Localizations.localeOf(context).languageCode,
        dayFormat: DayFormat.Common);
  }

  static double getTitleFontSize(String title) {
    if (ObjectUtil.isEmpty(title) || title.length < 10) {
      return 18;
    }
    int count = 0;
    List<String> list = title.split("");
    for (int i = 0, length = list.length; i < length; i++) {
      String ss = list[i];
      if (RegexUtil.isZh(ss)) {
        count++;
      }
    }
    return (count >= 10 || title.length > 16) ? 14 : 18;
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

class Dimens {
  static const double font_12 = 12;
  static const double font_14 = 14;
  static const double font_16 = 16;
  static const double font_18 = 18;

  static const double dp5 = 5;
  static const double dp10 = 10;
  static const double dp15 = 15;
  static const double dp20 = 20;
}

class Gaps {
  /// 水平间距
  static Widget hGap5 = SizedBox(width: Dimens.dp5);
  static Widget hGap10 = SizedBox(width: Dimens.dp10);
  static Widget hGap15 = SizedBox(width: Dimens.dp15);
  static Widget hGap20 = SizedBox(width: Dimens.dp20);

  /// 垂直间距
  ///

  static Widget vGap5 = SizedBox(height: Dimens.dp5);
  static Widget vGap10 = SizedBox(height: Dimens.dp10);
  static Widget vGap15 = SizedBox(height: Dimens.dp15);
  static Widget vGap20 = SizedBox(height: Dimens.dp20);
}

class TextStyleMacro {
  static TextStyle titleBloD163 = TextStyle(
    fontSize: Dimens.font_16,
    color: ColorsMacro.col_333,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleNor163 = TextStyle(
    fontSize: Dimens.font_16,
    color: ColorsMacro.col_333,
  );
  static TextStyle titleNor146 = TextStyle(
    fontSize: Dimens.font_14,
    color: ColorsMacro.col_666,
  );
  static TextStyle titleNor149 = TextStyle(
    fontSize: Dimens.font_14,
    color: ColorsMacro.col_999,
  );
  static TextStyle titleNor129 = TextStyle(
    fontSize: Dimens.font_12,
    color: ColorsMacro.col_999,
  );
  static TextStyle titleNor126 = TextStyle(
    fontSize: Dimens.font_12,
    color: ColorsMacro.col_666,
  );
  static const TextStyle appTitle = TextStyle(
    fontSize: Dimens.font_18,
    color: ColorsMacro.col_333,
  );
}
