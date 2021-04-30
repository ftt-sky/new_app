import 'package:new_app/data(%E7%BD%91%E7%BB%9C%E6%95%B0%E6%8D%AE%E5%B1%82)/data_index.dart';
import 'package:new_app/data(网络数据层)/protocol/gold_model.dart';
import 'package:new_app/data(网络数据层)/tt_network.dart';
import 'package:new_app/data(网络数据层)/api/apis.dart';
import 'package:new_app/common(常用类)/common_index.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_logutils.dart';

class GoldResitory {
  /// 获取轮播图 数据
  Future<List<BannerModel>> getBannerInfo() async {
    BaseResp<List> baseResp = await TTNetWorkingManager()
        .request(Method.get, CurrentApi.getPath(CurrentApi.banner));

    List<BannerModel> bannerList;
    if (baseResp.data != null) {
      bannerList = baseResp.data.map((e) {
        return BannerModel.fromJson(e);
      }).toList();
    }

    return bannerList;
  }

  /// 获取首页推荐文章
  Future<List<ReposModel>> getProjectList({int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await TTNetWorkingManager()
        .request<Map<String, dynamic>>(
            Method.get,
            CurrentApi.getWanAndroidPath(
                path: CurrentApi.PROJECT_LIST, page: page),
            data: data);
    List<ReposModel> list;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ReposModel.fromJson(value);
      }).toList();
    }
    TTLog.d(list);
    return list;
  }

  /// 获取公告号文章
  Future<List<ReposModel>> getWxArticleListProject(
      {int id, int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await TTNetWorkingManager()
        .request<Map<String, dynamic>>(
            Method.get,
            CurrentApi.getWanAndroidPath(
                path: CurrentApi.wxarticle + '/$id', page: page),
            data: data);
    List<ReposModel> list;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ReposModel.fromJson(value);
      }).toList();
    }
    TTLog.d('ddsadsadsadsada');
    return list;
  }

  /// 首页文章列表
  Future<List<ReposModel>> getArticleList({int page, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await TTNetWorkingManager()
        .request<Map<String, dynamic>>(Method.get,
            CurrentApi.getWanAndroidPath(path: CurrentApi.article, page: page),
            data: data);
    List<ReposModel> list;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ReposModel.fromJson(value);
      }).toList();
    }
    return list;
  }

  /// 获取公众号列表
  Future<List<TreeModel>> getWxArticleChapters() async {
    BaseResp<List> baseResp = await TTNetWorkingManager().request<List>(
        Method.get,
        CurrentApi.getWanAndroidPath(path: CurrentApi.WXARTICLE_CHAPTERS));
    List<TreeModel> treeList;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map((value) {
        return TreeModel.fromJson(value);
      }).toList();
    }
    return treeList;
  }

  /// 获取热门分类
  Future<List<TreeModel>> getProjectTree() async {
    BaseResp<List> baseResp = await TTNetWorkingManager().request<List>(
        Method.get,
        CurrentApi.getWanAndroidPath(path: CurrentApi.PROJECT_TREE));
    List<TreeModel> treeList;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map((value) {
        return TreeModel.fromJson(value);
      }).toList();
    }
    return treeList;
  }
}
