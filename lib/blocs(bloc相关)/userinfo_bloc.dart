import 'dart:collection';

import 'package:new_app/blocs(bloc%E7%9B%B8%E5%85%B3)/blocs_index.dart';
import 'package:new_app/current_index.dart';
import 'package:rxdart/rxdart.dart';

class UserInfoBloc implements BlocBase {
  BehaviorSubject<List<ReposModel>> _infoListBs =
      BehaviorSubject<List<ReposModel>>();

  Sink<List<ReposModel>> get _collectListSink => _infoListBs.sink;

  Stream<List<ReposModel>> get collectListStream =>
      _infoListBs.stream.asBroadcastStream();

  List<ReposModel> _collectList;
  int _collectPage = 0;

  Sink<StatusEvent> _homeEventSink;

  void setHomeEventSink(Sink<StatusEvent> eventSink) {
    _homeEventSink = eventSink;
  }

  @override
  void dispose() {
    _infoListBs.close();
  }

  UserInfoRepository _userInfoRepository = UserInfoRepository();

  @override
  Future getData({data, String labelId, int page}) {
    return getCollectList(labelId, page);
  }

  @override
  Future onLoadMore({data, String labelId}) {
    int _page = ++_collectPage;
    return getData(labelId: labelId, page: _page);
  }

  @override
  Future onRefresh({data, String labelId, bool isReload}) {
    _collectPage = 0;
    if (isReload == true) {
      _collectListSink.add(null);
    }
    return getData(labelId: labelId, page: _collectPage);
  }

  Future getCollectList(String labelId, int page) {
    return _userInfoRepository.getCollectList(page).then((value) {
      if (_collectList == null) {
        _collectList = [];
      }

      if (page == 0) {
        _collectList.clear();
      }
      _collectList.addAll(value);
      _collectListSink.add(UnmodifiableListView<ReposModel>(_collectList));
      _homeEventSink.add(StatusEvent(
          labelId, RequestStatus.fail, page == 0 ? 1 : 2,
          loadNum: 1));
    }).catchError((_) {
      if (ObjectUtil.isEmpty(_collectList)) {
        _infoListBs.sink.addError('error');
      }
      _collectPage--;
      _homeEventSink.add(StatusEvent(
          labelId, RequestStatus.fail, page == 0 ? 1 : 2,
          loadNum: 1));
    });
  }
}
