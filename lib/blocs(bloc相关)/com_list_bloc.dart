import 'package:new_app/blocs(bloc%E7%9B%B8%E5%85%B3)/bloc_provider.dart';
import 'package:new_app/data(网络数据层)/data_index.dart';
import 'package:rxdart/rxdart.dart';
import 'package:new_app/event(事件类)/event.dart';
import 'package:new_app/current_index.dart';
import 'dart:collection';

class ComListBloc implements BlocBase {
  GoldResitory _goldResitory = GoldResitory();
  BehaviorSubject<List<ReposModel>> _comListData =
      BehaviorSubject<List<ReposModel>>();
  Sink<List<ReposModel>> get _comListSink => _comListData.sink;
  Stream<List<ReposModel>> get comListStream => _comListData.stream;

  List<ReposModel> comList;

  int _comListPage = 0;

  BehaviorSubject<StatusEvent> _comListEvent = BehaviorSubject<StatusEvent>();
  Sink<StatusEvent> get _comListEventSink => _comListEvent.sink;
  Stream<StatusEvent> get comListEventStream =>
      _comListEvent.stream.asBroadcastStream();

  @override
  Future getData({data, String labelId, int cid, int page}) {
    switch (labelId) {
      case CurrentIds.titleReposTree:
        return getRepos(labelId, cid, page);
        break;
      case CurrentIds.titleWxArticleTree:
        return getWxArticle(labelId, cid, page);
        break;
      case CurrentIds.titleSystemTree:
        return getArticle(labelId, cid, page);
      default:
        return Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Future onLoadMore({data, String labeId, int cid}) {
    _comListPage = _comListPage + 1;
    return getData(labelId: labeId, page: _comListPage, cid: cid);
  }

  @override
  Future onRefresh({data, String labelId, int cid}) {
    switch (labelId) {
      case CurrentIds.titleReposTree:
        _comListPage = 1;
        break;
      default:
    }
    return getData(labelId: labelId, cid: cid, page: _comListPage);
  }

  @override
  void dispose() {
    _comListData.close();
    _comListEvent.close();
  }

  /// 获取项目列表
  Future getRepos(String labelId, int cid, int page) async {
    ComReq _comReq = new ComReq(cid);
    TTLog.d(_comReq.toJson());
    return _goldResitory
        .getProjectList(page: page, data: _comReq.toJson())
        .then((list) {
      if (comList == null) comList = [];
      if (page == 1) {
        comList.clear();
      }
      TTLog.d('当前页数 ------------ $page');
      comList.addAll(list);
      _comListSink.add(UnmodifiableListView<ReposModel>(comList));
      _comListEventSink.add(new StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RequestStatus.noMore
              : RequestStatus.success,
          page == 1 ? 1 : 2,
          cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(new StatusEvent(
          labelId, RequestStatus.fail, page == 1 ? 1 : 2,
          cid: cid));
    });
  }

  /// 获取微信公共号文章列表
  Future getWxArticle(String labelId, int cid, int page) async {
    return _goldResitory
        .getWxArticleListProject(id: cid, page: page)
        .then((value) {
      if (comList == null) {
        comList = [];
      }
      if (page == 1) {
        comList.clear();
      }
      comList.addAll(value);
      _comListSink.add(UnmodifiableListView<ReposModel>(comList));
      _comListEventSink.add(new StatusEvent(
          labelId,
          ObjectUtil.isEmpty(value)
              ? RequestStatus.noMore
              : RequestStatus.success,
          page == 1 ? 1 : 2,
          cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(new StatusEvent(
          labelId, RequestStatus.fail, page == 1 ? 1 : 2,
          cid: cid));
    });
  }

  /// 获取首页文章列表
  Future getArticle(String labelId, int cid, int page) async {
    ComReq _comReq = new ComReq(cid);
    return _goldResitory
        .getArticleList(page: page, data: _comReq.toJson())
        .then((list) {
      if (comList == null) comList = [];
      if (page == 0) {
        comList.clear();
      }
      comList.addAll(list);
      _comListSink.add(UnmodifiableListView<ReposModel>(comList));
      _comListEventSink.add(new StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RequestStatus.noMore
              : RequestStatus.success,
          1,
          cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink
          .add(new StatusEvent(labelId, RequestStatus.fail, 1, cid: cid));
    });
  }
}
