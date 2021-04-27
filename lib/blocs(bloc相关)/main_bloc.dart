import 'dart:collection';

import 'package:new_app/blocs(bloc%E7%9B%B8%E5%85%B3)/bloc_provider.dart';
import 'package:new_app/data(%E7%BD%91%E7%BB%9C%E6%95%B0%E6%8D%AE%E5%B1%82)/protocol/gold_model.dart';

import 'package:new_app/data(网络数据层)/repository/repositoty_index.dart';
import 'package:new_app/res(%E8%B5%84%E6%BA%90%E6%96%87%E4%BB%B6)/strings.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_logutils.dart';
import 'package:rxdart/rxdart.dart';

import 'package:new_app/event(事件类)/event.dart';

class MainBloc implements BlocBase {
  /// 网络请求
  ///

  int requestNum = 0;
  GoldResitory _resitory = GoldResitory();

  /// 获取banner
  BehaviorSubject<List<BannerModel>> _banner =
      BehaviorSubject<List<BannerModel>>();
  Sink<List<BannerModel>> get _bannerSink => _banner.sink;
  Stream<List<BannerModel>> get bannerStream => _banner.stream;

  /// 热门推荐文章
  BehaviorSubject<List<ReposModel>> _recRepos =
      BehaviorSubject<List<ReposModel>>();
  Sink<List<ReposModel>> get _recReposSink => _recRepos.sink;
  Stream<List<ReposModel>> get recReposStream => _recRepos.stream;

  /// 配置获取微信推荐公共号 Bloc
  BehaviorSubject<List<ReposModel>> _recWxArticle =
      BehaviorSubject<List<ReposModel>>();
  Sink<List<ReposModel>> get _recWxArticleSink => _recWxArticle.sink;
  Stream<List<ReposModel>> get recWxArticleStream => _recWxArticle.stream;

  /// main_bloc 状态监听
  // ignore: close_sinks
  BehaviorSubject<StatusEvent> _homeEvent = BehaviorSubject<StatusEvent>();
  Sink<StatusEvent> get homeEventSink => _homeEvent.sink;
  Stream<StatusEvent> get homeEventStream =>
      _homeEvent.stream.asBroadcastStream();

  MainBloc() {
    TTLog.d('MainBloc init');
  }

  @override
  Future getData({data, String labelId, int page}) {
    switch (labelId) {
      case CurrentIds.titleHome:
        return getHomeData(labelId);
        break;
      default:
        return Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Future onLoadMore({data, String labeId}) {
    return getData(labelId: labeId, page: 0);
  }

  @override
  Future onRefresh({data, String labelId, bool isReload}) {
    return getData(labelId: labelId, page: 0);
  }

  @override
  void dispose() {
    _banner.close();
    _recRepos.close();
    _recWxArticle.close();
  }

  /// 自定义方法
  ///
  ///

  /// 获取首页数据
  Future getHomeData(String labelId) {
    getRecrepos(labelId);
    //getRecWxArticle(labelId);
    return getBanner(labelId);
  }

  /// 获取首页推荐文章
  Future getRecrepos(String labelId) async {
    ComReq _comReq = ComReq(402);
    _resitory.getProjectList(data: _comReq.toJson()).then((value) {
      if (value.length > 6) {
        value = value.sublist(0, 6);
      }
      _recReposSink.add(UnmodifiableListView<ReposModel>(value));
    });
  }

  /// 获取轮播图数据
  Future getBanner(String labelId) {
    return _resitory.getBannerInfo().then((value) {
      _bannerSink.add(UnmodifiableListView<BannerModel>(value));
      configRequestEvent(labelId, RequestStatus.success);
    }).catchError((_) {
      configRequestEvent(labelId, RequestStatus.fail);
    });
  }

  /// 监听公共号 数据变化
  Future getRecWxArticle(String labelId) async {
    int _id = 408;
    _resitory.getWxArticleListProject(id: _id).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recWxArticleSink.add(UnmodifiableListView<ReposModel>(list));
      configRequestEvent('tt', RequestStatus.success);
    }).catchError((_) {
      configRequestEvent('tt', RequestStatus.fail);
    });
  }

  /// 配置网络请求状态
  void configRequestEvent(String labelId, RequestStatus status) {
    requestNum++;
    homeEventSink.add(StatusEvent(labelId, status, 1, loadNum: requestNum));
  }
}
