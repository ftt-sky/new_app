import 'package:new_app/current_index.dart';
import 'package:new_app/data(%E7%BD%91%E7%BB%9C%E6%95%B0%E6%8D%AE%E5%B1%82)/data_index.dart';
import 'package:new_app/data(网络数据层)/protocol/gold_model.dart';
import 'package:new_app/data(网络数据层)/tt_network.dart';
import 'package:new_app/data(网络数据层)/api/apis.dart';
import 'package:new_app/common(常用类)/common_index.dart';

class UserInfoRepository {
  Future<UserModel> login(LoginReq req) async {
    BaseResp<Map<String, dynamic>> baseResp = await TTNetWorkingManager()
        .request<Map<String, dynamic>>(Method.post, CurrentApi.user_login,
            data: req.toJson());
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    baseResp.response.headers.forEach((String name, List<String> values) {
      if (name == 'set-cookie') {
        String cookie = values.toString();
        SpUtil.putString(BaseConstant.keyAppToken, cookie);
        TTNetWorkingManager().setCookie(cookie);
      }
    });

    UserModel model = UserModel.fromJson(baseResp.data);
    SpUtil.putObject(BaseConstant.keyUserModel, model);
  }

  Future<UserModel> register(RegisterReq req) async {
    BaseResp<Map<String, dynamic>> baseResp = await TTNetWorkingManager()
        .request<Map<String, dynamic>>(Method.post, CurrentApi.user_register,
            data: req.toJson());
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    baseResp.response.headers.forEach((String name, List<String> values) {
      if (name == 'set-cookie') {
        String cookie = values.toString();
        SpUtil.putString(BaseConstant.keyAppToken, cookie);
        TTNetWorkingManager().setCookie(cookie);
      }
    });

    UserModel model = UserModel.fromJson(baseResp.data);
    SpUtil.putObject(BaseConstant.keyUserModel, model);
  }

  /// 获取收藏列表
  Future<List<ReposModel>> getCollectList(int page) async {
    BaseResp<Map<String, dynamic>> baseResp = await TTNetWorkingManager()
        .request<Map<String, dynamic>>(
            Method.get,
            CurrentApi.getWanAndroidPath(
                path: CurrentApi.lg_collect_list, page: page));
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    List<ReposModel> list;
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((e) {
        ReposModel model = ReposModel.fromJson(e);
        model.collect = true;
        return model;
      }).toList();
    }
    return list;
  }

  /// 收藏
  Future<bool> collect(int id) async {
    BaseResp baseResp = await TTNetWorkingManager().request(Method.post,
        CurrentApi.getWanAndroidPath(path: CurrentApi.lg_collect, page: id));
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    return true;
  }

  /// 取消收藏
  Future<bool> unCollect(int id) async {
    BaseResp baseResp = await TTNetWorkingManager().request(
        Method.post,
        CurrentApi.getWanAndroidPath(
            path: CurrentApi.lg_uncollect_originid, page: id));
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    return true;
  }
}
