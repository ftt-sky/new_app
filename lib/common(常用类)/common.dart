import 'package:flutter/foundation.dart';

class Constant {
  static const String keyLanguage = 'key_language';

  /// 域名
  static String setverAddress = getServe();

  static const int status_success = 0;

  /// 默认页数
  static const int default_page = 0;

  /// 服务器的type
  static const int default_server = 0;

  /// 测试服务器
  static const String test_Server = "https://www.wanandroid.com/";

  /// 予发布服务器
  static const String release_Server = test_Server;

  /// 正式环境
  static const String formal_Server = test_Server;

  static const String key_theme_color = 'key_theme_color';
  static const String key_guide = 'key_guide';
  static const String key_splash_model = 'key_splash_models';

  static const int type_sys_update = 1;
  static const int type_refresh_all = 5;

  /// 通过配置 获取域名
  static String getServe() {
    if (default_page == 0) {
      return test_Server;
    } else if (default_page == 1) {
      return release_Server;
    } else {
      return formal_Server;
    }
  }
}

class AppConfig {
  static const String appId = 'com.thl.flutterwanandroid';
  static const String appName = 'flutter_wanandroid';
  static const String version = '0.2.5';
  static const bool isDebug = kDebugMode;
}
