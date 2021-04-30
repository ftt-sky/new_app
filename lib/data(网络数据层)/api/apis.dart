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

  /// 项目分类
  static const String PROJECT_TREE = "project/tree";

  /// 获取公众号列表 http://wanandroid.com/wxarticle/chapters/json
  static const String WXARTICLE_CHAPTERS = "wxarticle/chapters";

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
