import 'package:new_app/common(常用类)/common_index.dart';

class CurrentApi {
  /// 轮播图
  static const String banner = 'banner/json';

  /// 首页文章列表
  static const String article = "article/list";

  /// 公告号文章列表
  static const String wxarticle = "wxarticle/list";

  /// 项目列表数据
  static const String PROJECT_LIST = "project/list";

  /// 体系数据 http://www.wanandroid.com/tree/json
  static const String TREE = "tree";

  /// 项目分类
  static const String PROJECT_TREE = "project/tree";

  /// 最新项目tab (首页的第二个tab) http://wanandroid.com/article/listproject/0/json
  static const String ARTICLE_LISTPROJECT = "article/listproject";

  /// 获取公众号列表 http://wanandroid.com/wxarticle/chapters/json
  static const String WXARTICLE_CHAPTERS = "wxarticle/chapters";

  /// 查看某个公众号历史数据 http://wanandroid.com/wxarticle/list/405/1/json
  /// 在某个公众号中搜索历史文章 http://wanandroid.com/wxarticle/list/405/1/json?k=Java
  static const String WXARTICLE_LIST = "wxarticle/list";

  static const String user_register = "user/register"; //注册
  static const String user_login = "user/login"; //登录
  static const String user_logout = "user/logout"; //退出

  static const String lg_collect_list = "lg/collect/list"; //收藏文章列表
  static const String lg_collect = "lg/collect"; //收藏站内文章
  static const String lg_uncollect_originid = "lg/uncollect_originId"; //取消收藏

  /// 项目分类
  /// 拼接URL
  static String getPath(String path) {
    StringBuffer stringBuffer = StringBuffer(Constant.setverAddress);
    if (path != null) {
      stringBuffer.write(path);
    }
    print(stringBuffer.toString());
    return stringBuffer.toString();
  }

  static String getWanAndroidPath(
      {String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(Constant.setverAddress);
    if (path != null) {
      sb.write(path);
    }
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    print(sb.toString());
    return sb.toString();
  }
}
