

import 'package:new_app/models(实体类)/currentModel.dart';



class CurrentRepository {


  /// 模拟获取广告图
  Future<SplashAdModel> getSplashAdInfo() {
    return Future.delayed(Duration(microseconds: 500), () {
      return SplashAdModel(
        title: "广告",
        content: "广告",
        url: 'https://www.jianshu.com',
        imgUrl: 'https://img2.woyaogexing.com/2020/03/10/e5cfaf077edb4d4e83465e27aae25795!1080x1920.jpeg',
      );
    });
  }
}